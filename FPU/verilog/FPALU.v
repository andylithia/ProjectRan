// Implementation of the FPALU (FP29iADD, FP16iMUL)
// For the W4823 FIR Project
// Anhang Li - Nov. 19 2021

// TODO: 
// 1. Add Latches to minimize useless flipping

//            FORMAT  SIGN  EXP  MANTISSA  WIDTH
//  RAW IEEE  FP16    1     5    10        16
//  INPUT     FP16i   1     5    11        17
//  POST MUL  FP29i   1     6    22        29
//  POST ACC  FP29i   1     6    22        29
//  OUTPUT    FP16    1     5    10        16 

module FPALU (
	input           rst_n,
	input           clk,
	
	input           din_uni_a_sgn,
	input [5:0]     din_uni_a_exp,
	input [21:0]    din_uni_a_man_dn,   // Always Left-Aligned, Denorm

	input           din_uni_b_sgn,
	input [5:0]     din_uni_b_exp,
	input [21:0]    din_uni_b_man_dn,   // Always Left-Aligned, Denorm

	input           add_muln,           // 1: Adder Mode, 0: Multiplier Mode
	output          dout_uni_y_sgn,
	output [5:0]    dout_uni_y_exp, 
	output [21:0]   dout_uni_y_man_dn

);
// ----- CONSTANTS -----
localparam ML_MANSIZE = 11;
localparam ML_EXPSIZE = 5;
localparam ML_EXPBIAS = 2**(ML_EXPSIZE-1)-1;
localparam ML_FPSIZE  = 1 + ML_EXPSIZE + ML_MANSIZE;
localparam AL_MANSIZE = 2 * ML_MANSIZE;
localparam AL_EXPSIZE = 1 + ML_EXPSIZE;
localparam AL_FPSIZE  = 1 + AL_EXPSIZE + AL_MANSIZE;
localparam AL_EXPBIAS = 2**(AL_EXPSIZE-1)-1;

localparam OPSIZE = 2;

localparam OPC_ADD29i  = 2'b11;	// Adding   Mode
localparam OPC_MUL16i  = 2'b10;	// Multiply Mode
localparam OPC_ADDSKIP = 2'b01;	// We found a zero, skip the addition entirely
localparam OPC_SLEEP   = 2'b00; // Low Power Mode


// ----- PIPELINE STAGE 1 -----
//
wire [OPSIZE-1:0] s1_opcode = add_muln;

// ACHTUNG:
// You MUST deal with zeros somewhere, maybe here.
// e.g. adding 0e10 to 123e0 will result in 0e10, which is clearly incorrect
// when one of the input is all zeros, you must give up the current exponent compare


// ADDER: Exponent Compare
wire [AL_EXPSIZE:0]   s1_ea_sub_eb = {1'b0,din_uni_a_exp} - {1'b0,din_uni_b_exp};
wire                  s1_ea_lt_eb  = s1_ea_sub_eb[AL_EXPSIZE];
wire                  s1_ea_gte_eb  = ~s1_ea_lt_eb;
wire [AL_EXPSIZE-1:0] s1_ea_sub_eb_abs = s1_ea_gte_eb ?  s1_ea_sub_eb[AL_EXPSIZE-1:0] : {~s1_ea_sub_eb+1'b1};
// ADDER: Sign Compare
wire       s1_addsubn = ~(din_uni_a_sgn ^ din_uni_b_sgn);	// 1: ADD, 0: SUB
// ADDER: Shifter XCHG
// Exchange while waiting for ABS(EA-EB) completion
wire [AL_MANSIZE-1:0]	s1_mmux_lhs;
wire [AL_MANSIZE-1:0]	s1_mmux_rhs;
xchg #(.DWIDTH(22)) s1_u_manxchg(
	.ia(din_uni_a_man_dn),
	.ib(din_uni_b_man_dn),
	.xchg(s1_ea_lt_eb),		// B has larger EXP, Right shift A.MAN to align with B.MAN 
	.oa(s1_mmux_lhs),
	.ob(s1_mmux_rhs)
);

// Multiplier Stage 1
// wire [ML_MANSIZE-1:0] s1_wt_lhs = din_uni_a_man_dn[AL_MANSIZE-1:AL_MANSIZE-ML_MANSIZE];
// wire [ML_MANSIZE-1:0] s1_wt_rhs = din_uni_b_man_dn[AL_MANSIZE-1:AL_MANSIZE-ML_MANSIZE];

// This most definitely need more optimization
// wire [AL_MANSIZE-1:0] s1_mulout = s1_wt_lhs * s1_wt_rhs; 
// MULTIPLIER: Booth Encoder
localparam  BR4SYM_SIZE = 3;		// Radix-4 Booth Symbol Size

wire [ML_MANSIZE+2:0] s1_br4enc_input =
	{2'b00, din_uni_b_man_dn[AL_MANSIZE-1:AL_MANSIZE-ML_MANSIZE], 1'b0};
wire [ML_MANSIZE-1:0] s1_mana = din_uni_a_man_dn[AL_MANSIZE-1:AL_MANSIZE-ML_MANSIZE];
wire [(BR4SYM_SIZE*6)-1:0] 		s1_br4enc;
wire [(ML_MANSIZE+1)*6-1:0]		s1_br4_pp;
wire [5:0]                      s1_br4_s;
genvar gi;
generate
	for(gi=0;gi<6;gi=gi+1) begin : gen_br4enc
		booth_enc_r4 s1_u_br4enc (
			.bin(s1_br4enc_input[2*(gi+1):2*gi]),
			.br4_out(s1_br4enc[(gi+1)*3-1:gi*3])
		);
		booth_ppgen_r4 s1_u_br4ppgen (
			.a(s1_mana),
			.br4(s1_br4enc[(gi+1)*3-1:gi*3]),
			.o(s1_br4_pp[(ML_MANSIZE+1)*(gi+1)-1:(ML_MANSIZE+1)*(gi)]),
			.s(s1_br4_s[gi])
		);
	end
endgenerate


// ----- PIPELINE STAGE 2 -----
//
// Pipeline Signal Relay
reg [OPSIZE-1:0]     s2_opcode_r;
always @(posedge clk) begin
	s2_opcode_r <= s1_opcode;
end

// ADDER: Signal Relay
reg [AL_EXPSIZE-1:0] s2_ea_sub_eb_abs_r;
reg                  s2_ea_gte_eb_r;
reg [AL_MANSIZE-1:0] s2_mmux_lhs_r;
reg [AL_MANSIZE-1:0] s2_mmux_rhs_r;
reg                  s2_addsubn_r;
always @(posedge clk) begin
	s2_ea_sub_eb_abs_r <= s1_ea_sub_eb_abs;
	s2_ea_gte_eb_r     <= s1_ea_gte_eb;
	s2_mmux_lhs_r      <= s1_mmux_lhs;
	s2_mmux_rhs_r      <= s1_mmux_rhs;
	s2_addsubn_r       <= s1_addsubn;
end

// ADDER: LHS Zero Detector
// This is added to deal with adding with denormalized zero
// when the zero has a larger exponent
wire              s2_lhs_is_zero = ~(|s2_mmux_lhs_r);
wire [OPSIZE-1:0] s2_opcode_mod;
  assign s2_opcode_mod = ((s2_opcode_r==OPC_ADD29i)&&s2_lhs_is_zero) ? OPC_ADDSKIP : s2_opcode_r;

// ADDER: Shifter
// When shifting by [MSB], the output becomes zero
wire [31:0]	s2_bsr_out;
wire [AL_MANSIZE-1:0] s2_bsr_out_gated = s2_ea_sub_eb_abs_r[AL_EXPSIZE-1]  ? {AL_MANSIZE{1'b0}} : s2_bsr_out[31:32-AL_MANSIZE];
  
bsr #(.SWIDTH(AL_EXPSIZE-1)) s2_u_bsr(
  .din({s2_mmux_rhs_r,10'b0}),
	.s(s2_ea_sub_eb_abs_r[AL_EXPSIZE-2:0]),
	.filler(1'b0),
	.dout(s2_bsr_out)
);

// ADDER: Exchanger & Inverter
//
wire [AL_MANSIZE-1:0] s2_mmux2_lhs;
wire [AL_MANSIZE-1:0] s2_mmux2_rhs;
xchg #(.DWIDTH(AL_MANSIZE)) s2_u_manxchg(
	.ia(s2_mmux_lhs_r),
	.ib(s2_bsr_out_gated),
	.xchg(s2_ea_gte_eb_r),
	.oa(s2_mmux2_lhs),
	.ob(s2_mmux2_rhs)
);

wire [AL_MANSIZE:0]   s2_mmux3_rhs_addsub = s2_addsubn_r ? s2_mmux2_rhs : ~s2_mmux2_rhs;

// ADDER: Denorm Zero: Bypass Path
wire [AL_MANSIZE:0]   s2_mmux3_lhs_addsub;
assign s2_mmux3_lhs_addsub = (s2_lhs_is_zero) ? {1'b0,s2_mmux_rhs_r} : {1'b0, s2_mmux2_lhs};

// MULTIPLIER, Part I: Partial Product Generation
// reg [(BR4SYM_SIZE*6)-1:0] s2_br4enc_r; // Multiplier Encoded in Radix-4 Booth Symbols
// always @(posegde clk)     s2_br4enc_r <= s1_br4enc;
reg [AL_MANSIZE-1:0]		s2_many_dummy_r;
always @(posedge clk) s2_many_dummy_r <= 0;
// Partial Product Generation:

// Multiplier Signal Relay
reg [AL_EXPSIZE-1:0]	        s2_ea_r;
reg [AL_EXPSIZE-1:0]	        s2_eb_r;
reg [(ML_MANSIZE+1)*6-1:0]		s2_br4_pp_r;
reg [5:0]                       s2_br4_s_r;
always @(posedge clk) begin
	s2_ea_r      <= din_uni_a_exp;
	s2_eb_r      <= din_uni_b_exp;
	s2_br4_pp_r  <= s1_br4_pp;
	s2_br4_s_r   <= s1_br4_s;
end

// Booth Radix-4 Partial Summation
wire [11:0] pp0 = s2_br4_pp_r[12*1-1:12*0];
wire [11:0] pp1 = s2_br4_pp_r[12*2-1:12*1];
wire [11:0] pp2 = s2_br4_pp_r[12*3-1:12*2];
wire [11:0] pp3 = s2_br4_pp_r[12*4-1:12*3];
wire [11:0] pp4 = s2_br4_pp_r[12*5-1:12*4];
wire [11:0] pp5 = s2_br4_pp_r[12*6-1:12*5];
reg [16:0]        s2_ps0;
reg [16:0]        s2_ps1;
wire              s2_s2 = s2_br4_s_r[2];
wire              s2_s5 = s2_br4_s_r[5];
always @* begin
	s2_ps0 =          {{5{s2_br4_s_r[0]}},pp0};
	s2_ps0 = s2_ps0 + {{3{s2_br4_s_r[1]}},pp1,1'b0,s2_br4_s_r[0]};
	s2_ps0 = s2_ps0 + {{1{s2_br4_s_r[2]}},pp2,1'b0,s2_br4_s_r[1], 2'b0};

	s2_ps1 =          {{5{s2_br4_s_r[3]}},pp3};
	s2_ps1 = s2_ps1 + {{3{s2_br4_s_r[4]}},pp4,1'b0,s2_br4_s_r[3]};
	s2_ps1 = s2_ps1 + {{1{s2_br4_s_r[5]}},pp5,1'b0,s2_br4_s_r[4], 2'b0};
	/*
	s2_ps1 =          {{3{s2_br4_s_r[3]}},pp3};
	s2_ps1 = s2_ps1 + {{2{s2_br4_s_r[4]}},pp4,s2_br4_s_r[3]};
	s2_ps1 = s2_ps1 + {   s2_br4_s_r[5],  pp5,s2_br4_s_r[4]};
	*/
end

// ----- PIPELINE STAGE 3 -----
//
// SEGMENT 1. Pipeline Signal Relay
reg [OPSIZE-1:0]     s3_opcode_r;
always @(posedge clk) begin
	if(s2_lhs_is_zero&&(s2_opcode_r==OPC_ADD29i)) 
                       s3_opcode_r <= OPC_ADDSKIP;
	else               s3_opcode_r <= s2_opcode_r;
end

// ADDER: Summing (CLA)
reg [AL_MANSIZE:0]  s3_lhs_r;
reg [AL_MANSIZE:0]  s3_rhs_r;
reg                 s3_addsubn_r;

always @(posedge clk) begin
	s3_lhs_r     <= s2_mmux3_lhs_addsub;
	s3_rhs_r     <= s2_mmux3_rhs_addsub;
	s3_addsubn_r <= s2_addsubn_r;
end

wire [AL_MANSIZE:0] s3_alu_out;

  cla_adder #(.DATA_WID(AL_MANSIZE+1)) s3_s4_u_cla(
	.in1(s3_lhs_r),
	.in2(s3_rhs_r),
	.carry_in(~s3_addsubn_r),
	.sum(s3_alu_out),
	.carry_out()
);
// assign s3_alu_out = s3_lhs_r + s3_rhs_r + ~s3_addsubn_r;
// Multiplier Signal Relay
reg [AL_EXPSIZE-1:0]	s3_ea_r;
reg [AL_EXPSIZE-1:0]	s3_eb_r;
reg                     s3_ea_gte_eb_r;
always @(posedge clk) begin
	s3_ea_r        <= s2_ea_r;
	s3_eb_r        <= s2_eb_r;
	s3_ea_gte_eb_r <= s2_ea_gte_eb_r;
end

// ADDER: Denorm Zero: Bypass Path
wire [AL_MANSIZE:0] s3_mmux_postalu;
assign s3_mmux_postalu = (s3_opcode_r==OPC_ADDSKIP) ? s3_lhs_r : s3_alu_out;

reg [AL_MANSIZE-1:0]	s3_many_dummy_r;
always @(posedge clk) 	s3_many_dummy_r <= s2_many_dummy_r;


// BR4: Final Summation
reg [21:0]        s3_mulout;
reg [16:0]        s3_ps0_r;
reg [16:0]        s3_ps1_r;
reg               s3_s2_r;
reg               s3_s5_r;
always @(posedge clk) begin
	s3_ps0_r <= s2_ps0;
	s3_ps1_r <= s2_ps1;
	s3_s2_r  <= s2_s2;
	s3_s5_r  <= s2_s5;
end

always @* begin
	s3_mulout =             {{5{s3_ps0_r[16]}}, s3_ps0_r               };
	s3_mulout = s3_mulout + {                  s3_ps1_r, 1'b0, s3_s2_r, 4'b0};
	s3_mulout = s3_mulout + {11'b0,        s3_s5_r,           10'b0};
end



// ----- PIPELINE STAGE 4 -----
// 
// General Note for S4 and S5:
//  In a regular FP Pipeline, all operations need to perform zero detect
//  and shifting. (i.e. Normalization)
//  But our application, FIR, is special:
//  Normalization in constant multiplication is useless, 
//  The result will be re-normalized anyway during the accumulation
//  so we can actually save two cycles on multiplication
//  

// UNIFIED OUTPUT STAGE: Zero Detect and EXP Bias Calculation
// Pipeline Signal Relay
reg [OPSIZE-1:0]     s4_opcode_r;
reg [AL_MANSIZE:0]   s4_alu_out_r;
  reg [AL_MANSIZE:0]  s4_lzdi;
reg [4:0]            s4_lzd;
always @(posedge clk) begin
	s4_alu_out_r <= s3_mmux_postalu;
	s4_opcode_r  <= s3_opcode_r;
  /*
	if(s3_opcode_r == OPC_ADD29i) begin
		s4_lzdi <= s3_mmux_postalu;
	end else if (s3_opcode_r == OPC_MUL16i) begin
		s4_lzdi <= s3_many_dummy_r;
	end
    */
end
  
  assign s4_lzdi = s4_alu_out_r;
  
  
// UNIFIED: Leading Zero Detect:
count_lead_zero #(.W_IN(32)) s4_u_lzd(
  .in({s4_lzdi,{(32-AL_MANSIZE-1){1'b0}}}),
  .out(s4_lzd)
);

// Multiplier Signal Relay
reg [AL_EXPSIZE-1:0]	s4_ea_r;
reg [AL_EXPSIZE-1:0]	s4_eb_r;
reg                     s4_ea_gte_eb_r;
always @(posedge clk) begin
	s4_ea_r        <= s3_ea_r;
	s4_eb_r        <= s3_eb_r;
	s4_ea_gte_eb_r <= s3_ea_gte_eb_r;
end
// I guess the last two stage can also be by passed for denorm zero
// May not be necessary, we'll see when it comes to the multiplier impl.

// We don't deal with zeros here:
//  Because the mantissa within the ALU is always DENORMALIZED,
//  Adding zeros is just adding zeros to the mantissa.
// With additional processing you may be able to get lower power
//  (By skipping zero in the entire addition pipeline)
//  but the chance of having zero is not high anyway. 
// READ the note at stage 1 for more info

// ----- PIPELINE STAGE 5 -----
// UNIFIED OUTPUT STAGE: Final Shifting, Truncation, etc
// Pipeline Signal Relay
reg [OPSIZE-1:0]     s5_opcode_r;
always @(posedge clk) begin
	s5_opcode_r <= s4_opcode_r;
end

// UNIFIED: Final Shifter
reg [AL_MANSIZE:0] s5_alu_out_r;
reg [4:0]          s5_lzd_r;
always @(posedge clk) begin
	s5_alu_out_r <= s4_alu_out_r;
	s5_lzd_r     <= s4_lzd;
end
  reg [31:0] s5_bsl_out;
bsl #(.SWIDTH(5)) s5_u_bsl (
  .din({9'b0,s5_alu_out_r}),
	.s(s5_lzd_r),
	.filler(1'b0),
  .dout(s5_bsl_out)
);
  assign dout_uni_y_man_dn = s5_bsl_out[26-:22];

// UNIFIED: Exponent Adjust

// Signal Relay
reg [AL_EXPSIZE-1:0]	s5_ea_r;
reg [AL_EXPSIZE-1:0]	s5_eb_r;
reg                     s5_ea_gte_eb_r;
always @(posedge clk) begin
	s5_ea_r        <= s4_ea_r;
	s5_eb_r        <= s4_eb_r;
	s5_ea_gte_eb_r <= s4_ea_gte_eb_r;
end
wire                  s5_ea_lt_eb = ~s5_ea_gte_eb_r;
wire [AL_EXPSIZE-1:0] s5_expadj_skip = 0;
wire [AL_EXPSIZE:0]   s5_expadj_mul;
wire [AL_EXPSIZE-1:0] s5_expadj_add;
reg  [AL_EXPSIZE:0]   s5_expadj_final;
assign s5_expadj_mul  = s5_ea_r + s5_eb_r - AL_EXPBIAS + 1;
assign s5_expadj_add  = s5_ea_gte_eb_r ?  s5_ea_r : s5_eb_r;
assign s5_expadj_skip = s5_ea_lt_eb    ?  s5_eb_r : s5_ea_r;
always @* begin
  /*
	if(s5_opcode_r == OPC_ADD29i)				 
		s5_expadj_final = {1'b0,s5_expadj_add} - s5_lzd_r;
	else if (s5_opcode_r == OPC_MUL16i) 
		s5_expadj_final = s5_expadj_mul - s5_lzd_r;
	else	// Pass Thru
		s5_expadj_final = {1'b0, s5_expadj_skip};
	*/
  s5_expadj_final = {1'b0,s5_expadj_add} - s5_lzd_r - 1;
end

  assign dout_uni_y_exp = s5_expadj_final[AL_EXPSIZE-1:0];

endmodule /* FPALU */