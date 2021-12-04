// Implementation of the FPALU (FP29iADD, FP16iMUL)
// For the W4823 FIR Project
// Anhang Li - Nov. 19 2021

// TODO: 
// 0. Deal with FP29i Overflow (Can be ignored)
// 1. Add Latches to minimize useless flipping
// 2. 

`timescale 1ns/1ps
module FPALU (
	// input           rst_n,
	input           clk,
	input [1:0]		opcode,

	input           din_uni_a_sgn,
	input [5:0]     din_uni_a_exp,
	input [21:0]    din_uni_a_man_dn,   // Always Right-Aligned, Denorm

	input           din_uni_b_sgn,
	input [5:0]     din_uni_b_exp,
	input [21:0]    din_uni_b_man_dn,   // Always Right-Aligned, Denorm

	// input           add_muln,           // 1: Adder Mode, 0: Multiplier Mode
	output          dout_uni_y_sgn,
	output [5:0]    dout_uni_y_exp, 
	output [21:0]   dout_uni_y_man_dn
);

// This option adds extra real number registers to assist debugging
// `define DEBUGINFO

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
// localparam OPC_SLEEP   = 2'b00; // Low Power Mode
// To set this into sleep mode, just disable the clock
localparam OPC_ADD29NORM = 2'b00;	// Add and Normalize (last accumulation)

// Input Wiring
// Dummy Connection for AL
wire [AL_EXPSIZE-1:0]   din_AL_expa = din_uni_a_exp;	//
wire [AL_EXPSIZE-1:0]   din_AL_expb = din_uni_b_exp;	//
wire [AL_MANSIZE-1:0]   din_AL_mana = din_uni_a_man_dn;	// 22b Denormalized
wire [AL_MANSIZE-1:0]   din_AL_manb = din_uni_b_man_dn;	// 22b Denormalized

// Right-Aligned for ML
wire [ML_EXPSIZE:0]     din_ML_expa = {1'b0,din_uni_a_exp[ML_EXPSIZE-1:0]};
wire [ML_EXPSIZE:0]     din_ML_expb = {1'b0,din_uni_b_exp[ML_EXPSIZE-1:0]};
reg [ML_MANSIZE-1:0]    din_ML_mana;
reg [ML_MANSIZE-1:0]    din_ML_manb;
// Dealing with denorm number
// wire s1_ml_ea_is_denorm = (din_ML_expa == ML_EXPBIAS);
wire s1_ml_ea_is_denorm = (|din_ML_expa) == 1'b0;
wire s2_ml_eb_is_denorm = (|din_ML_expb) == 1'b0;
always @* begin
	// din_ML_manx is 11 bit denormalized mantissa
	// din_uni_x_man_dn is 10 bit normalized mantissa
	if(s1_ml_ea_is_denorm) din_ML_mana = {din_uni_a_man_dn[ML_MANSIZE-2:0],1'b0};
	else                   din_ML_mana = {1'b1,din_uni_a_man_dn[ML_MANSIZE-2:0]};
	
	if(s1_ml_eb_is_denorm) din_ML_manb = {din_uni_a_man_dn[ML_MANSIZE-2:0],1'b0};
	else                   din_ML_manb = {1'b1, din_uni_b_man_dn[ML_MANSIZE-2:0]};
	// din_ML_manb = din_uni_b_man_dn[ML_MANSIZE-1:0];	// Always Denorm
end

`ifdef DEBUGINFO
	real a_real_FP16  [3:0];	// Can be Normalized
	real a_real_FP29i [3:0];	// Always Denorm
	real b_real_FP16i [3:0];	// Always Denorm
	real b_real_FP29i [3:0];	// Always Denorm
	real a_real_FP16_s5;		// Icarus Doesn't support real array dumping?
	real a_real_FP29i_s5;		// Written Explicitly...
	real b_real_FP16i_s5;		// |
	real b_real_FP29i_s5;		// /
	real y_real_FP29i;			// Always Denorm, Used in OP: ADDSKIP, ADD29i, MUL16i
	real y_real_FP29;			// Always Denorm, Used in OP: ADD29NORM
	real y_expected_ml;		// Reference Result of Multiplication
	real y_expected_ad;		// Reference Result of Addition
	integer many_expected_ml;	

	real mul_k1;
	real mul_ik1;
	reg  mul_valid;
	real add_k1;
	reg  add_valid; 
	
	always @* begin
		a_real_FP16  [0] = (1.0-2.0*din_uni_a_sgn) * din_ML_mana * 2.0**(-10.0) * 2**(din_ML_expa-15.0);
		a_real_FP29i [0] = (1.0-2.0*din_uni_a_sgn) * din_AL_mana * 2.0**(-21.0) * 2**(din_AL_expa-31.0);
		b_real_FP16i [0] = (1.0-2.0*din_uni_b_sgn) * din_ML_manb * 2.0**(-10.0) * 2**(din_ML_expb-15.0);
		b_real_FP29i [0] = (1.0-2.0*din_uni_b_sgn) * din_AL_manb * 2.0**(-21.0) * 2**(din_AL_expb-31.0);
		y_real_FP29i     = (1.0-2.0*dout_uni_y_sgn) * dout_uni_y_man_dn * 2.0**(-22.0 + dout_uni_y_exp - 31.0);
		y_expected_ml = a_real_FP16_s5  * b_real_FP16i_s5;
		y_expected_ad = a_real_FP29i_s5 + b_real_FP29i_s5;
		many_expected_ml = din_ML_mana * din_ML_manb;
		mul_k1 = y_real_FP29i / y_expected_ml;
		mul_ik1 = 1/mul_k1;
		mul_valid = ($abs(mul_k1)-1.0<0.0001);
		add_k1 = (y_real_FP29i / y_expected_ad);
		add_valid = ($abs(add_k1)-1.0<0.0001);
	end

	integer i;
	always @(posedge clk) begin
		for(i=3;i>0;i=i-1) begin
			a_real_FP16 [i]  <= a_real_FP16 [i-1];
			a_real_FP29i [i] <= a_real_FP29i [i-1];
			b_real_FP16i [i] <= b_real_FP16i [i-1];
			b_real_FP29i [i] <= b_real_FP29i [i-1];
		end
		a_real_FP16_s5  <= a_real_FP16[3];
		a_real_FP29i_s5 <= a_real_FP29i[3];
		b_real_FP16i_s5 <= b_real_FP16i[3];
		b_real_FP29i_s5 <= b_real_FP29i[3];
	end
`endif /* DEBUGINFO */


// +------------------------------------+
// |          PIPELINE STAGE 1          |
// +------------------------------------+

reg [OPSIZE-1:0] s1_opcode;
always @* begin
	s1_opcode = opcode;
end

// ACHTUNG:
// You MUST deal with zeros somewhere, maybe here.
// e.g. adding 0e10 to 123e0 will result in 0e10, which is clearly incorrect
// when one of the input is all zeros, you must give up the current exponent compare

// ADDER: Exponent Compare
wire [AL_EXPSIZE:0]   s1_ea_sub_eb = {1'b0,din_uni_a_exp} - {1'b0,din_uni_b_exp};
wire                  s1_ea_lt_eb  = s1_ea_sub_eb[AL_EXPSIZE];	// Inspect Borrow at MSB
wire                  s1_ea_gte_eb  = ~s1_ea_lt_eb;				// No Borrow -> EA-EB ≥ 0
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

// MULTIPLIER: Booth Encoder
localparam  BR4SYM_SIZE = 3;		// Radix-4 Booth Symbol Size
localparam  PPSIZE = ML_MANSIZE+1;
wire [ML_MANSIZE+2:0] s1_br4enc_input = {2'b00, din_ML_manb, 1'b0};
wire [(PPSIZE)*6-1:0]		    s1_br4_pp;	// BR4 Partial Products      (72bits)
wire [5:0]                      s1_br4_s;	// BR4 Partial Product Signs (12bits)
genvar gi;
generate
	for(gi=0;gi<6;gi=gi+1) begin : gen_br4enc
		// BR4 Partial Product Generator
		booth_ppgen_r4 s1_u_br4ppgen (
			.a(din_ML_mana),
			.br4(s1_br4enc_input[2*(gi+1):2*gi]),
			.o(s1_br4_pp[PPSIZE*(gi+1)-1:PPSIZE*(gi)]),
			.s(s1_br4_s[gi])
		);
	end
endgenerate

// +------------------------------------+
// |          PIPELINE STAGE 2          |
// +------------------------------------+
// Pipeline Signal Relay
reg [OPSIZE-1:0]     s2_opcode_r;
reg [AL_EXPSIZE-1:0] s2_expa_r;		// Save Exponents for S5
reg [AL_MANSIZE-1:0] s2_expb_r;		// /
reg                  s2_sa_r;
always @(posedge clk) begin
	s2_opcode_r <= s1_opcode;
	if(s1_opcode == OPC_ADD29i) begin
		s2_expa_r   <= din_uni_a_exp;
		s2_expb_r   <= din_uni_b_exp;
	end else if(s1_opcode == OPC_MUL16i) begin
		s2_expa_r   <= din_ML_expa;
		s2_expb_r   <= din_ML_expb;
	end
	s2_sa_r <= din_uni_a_sgn;
end

// ADDER: Signal Relay
reg [AL_EXPSIZE-1:0] s2_ea_sub_eb_abs_r;
reg                  s2_ea_gte_eb_r;
wire                 s2_ea_lt_eb = ~s2_ea_gte_eb_r;
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
// L: s2_mmux_lhs_r, R: s2_bsr_out_gated

// ADDER: Exchanger & Inverter
// This Exchanger is here for subtraction
/*
// Why is this here...? Probably brain farts
wire [AL_MANSIZE-1:0] s2_mmux2_lhs;
wire [AL_MANSIZE-1:0] s2_mmux2_rhs;
xchg #(.DWIDTH(AL_MANSIZE)) s2_u_manxchg(
	.ia(s2_mmux_lhs_r),
	.ib(s2_bsr_out_gated),
	// .xchg(s2_ea_lt_eb),
	.xchg(1'b0),
	.oa(s2_mmux2_lhs),
	.ob(s2_mmux2_rhs)
);
*/
wire [AL_MANSIZE-1:0] s2_mmux2_lhs = s2_mmux2_lhs;
wire [AL_MANSIZE-1:0] s2_mmux2_rhs = s2_bsr_out_gated;

wire [AL_MANSIZE:0]   s2_mmux3_rhs_addsub  = s2_addsubn_r ? s2_mmux2_rhs : ~s2_mmux2_rhs;
// ADDER: Denorm Zero: Bypass Path
// Use LHS as the bypass path to reduce delay
wire [AL_MANSIZE:0]   s2_mmux3_lhs_addsub;
assign s2_mmux3_lhs_addsub = (s2_lhs_is_zero) ? {1'b0,s2_mmux_rhs_r} : {1'b0, s2_mmux2_lhs};

// MULTIPLIER, Part II: Partial Product Summation 1
// Multiplier Signal Relay
reg [AL_EXPSIZE-1:0]	s2_ea_r;
reg [AL_EXPSIZE-1:0]	s2_eb_r;
reg [PPSIZE*6-1:0]		s2_br4_pp_r;
reg [5:0]               s2_br4_s_r;
always @(posedge clk) begin
	s2_ea_r      <= din_uni_a_exp;
	s2_eb_r      <= din_uni_b_exp;
	s2_br4_pp_r  <= s1_br4_pp;
	s2_br4_s_r   <= s1_br4_s;
end

// Booth Radix-4 Partial Summation
wire [PPSIZE-1:0]  pp0 = s2_br4_pp_r[PPSIZE*1-1:PPSIZE*0];
wire [PPSIZE-1:0]  pp1 = s2_br4_pp_r[PPSIZE*2-1:PPSIZE*1];
wire [PPSIZE-1:0]  pp2 = s2_br4_pp_r[PPSIZE*3-1:PPSIZE*2];
wire [PPSIZE-1:0]  pp3 = s2_br4_pp_r[PPSIZE*4-1:PPSIZE*3];
wire [PPSIZE-1:0]  pp4 = s2_br4_pp_r[PPSIZE*5-1:PPSIZE*4];
wire [PPSIZE-1:0]  pp5 = s2_br4_pp_r[PPSIZE*6-1:PPSIZE*5];
reg [PPSIZE+7-1:0] s2_ps0;
reg [PPSIZE+4-1:0] s2_ps1;
wire               s2_s2 = s2_br4_s_r[2];

always @* begin
	s2_ps0 =          {4'b0,{!s2_br4_s_r[0]},{2{s2_br4_s_r[0]}},pp0};
	s2_ps0 = s2_ps0 + {4'b0001,{!s2_br4_s_r[1]},pp1,1'b0,s2_br4_s_r[0]};
	s2_ps0 = s2_ps0 + {2'b01,{!s2_br4_s_r[2]},pp2,1'b0,s2_br4_s_r[1],2'b0};
	s2_ps1 =          {3'b001,{!s2_br4_s_r[3]},pp3};
	s2_ps1 = s2_ps1 + {1'b1,{!s2_br4_s_r[4]},pp4,1'b0,s2_br4_s_r[3]};
	s2_ps1 = s2_ps1 + {pp5,1'b0,s2_br4_s_r[4],2'b0};
end


// +------------------------------------+
// |          PIPELINE STAGE 3          |
// +------------------------------------+
//
// Pipeline Signal Relay
reg [OPSIZE-1:0]     s3_opcode_r;
reg [AL_EXPSIZE-1:0] s3_expa_r;		// Save Exponents for S5
reg [AL_MANSIZE-1:0] s3_expb_r;		// /
reg                  s3_sa_r;
always @(posedge clk) begin
	if(s2_lhs_is_zero&&(s2_opcode_r==OPC_ADD29i)) 
                       s3_opcode_r <= OPC_ADDSKIP;
	else               s3_opcode_r <= s2_opcode_r;
	s3_expa_r <= s2_expa_r;
	s3_expb_r <= s2_expb_r;
	s3_sa_r   <= s2_sa_r;
end

// ADDER: Summing
reg [AL_MANSIZE:0]  s3_lhs_r;		// Adder DP, 23b
reg [AL_MANSIZE:0]  s3_rhs_r;		// Adder DP, 23b
reg                 s3_addsubn_r;	// Adder DP

always @(posedge clk) begin
	s3_lhs_r     <= s2_mmux3_lhs_addsub;
	s3_rhs_r     <= s2_mmux3_rhs_addsub;
	s3_addsubn_r <= s2_addsubn_r;
end

// Multiplier Signal Relay
reg [AL_EXPSIZE-1:0]	s3_ea_r;
reg [AL_EXPSIZE-1:0]	s3_eb_r;
reg                     s3_ea_gte_eb_r;
always @(posedge clk) begin
	s3_ea_r        <= s2_ea_r;
	s3_eb_r        <= s2_eb_r;
	s3_ea_gte_eb_r <= s2_ea_gte_eb_r;
end

// MULTIPLIER: Final Summation Relay
reg [21:0]                s3_mulout;
reg [PPSIZE+7-1:0]        s3_ps0_r;
reg [PPSIZE+4-1:0]        s3_ps1_r;
reg                       s3_s2_r;
always @(posedge clk) begin
	s3_ps0_r <= s2_ps0;
	s3_ps1_r <= s2_ps1;
	s3_s2_r  <= s2_s2;
end

// UNIFIED: ALU Implementation
reg [AL_MANSIZE:0]   s3_alumux_lhs;	// 23bits (sign extended)
reg [AL_MANSIZE:0]   s3_alumux_rhs;	// 23bits (sign extended)
reg                  s3_alumux_cin;	// 
wire [AL_MANSIZE:0]  s3_alu_out;
always @(*) begin
	if(s3_opcode_r==OPC_ADD29i) begin
		// Adder
		s3_alumux_lhs = s3_lhs_r;
		s3_alumux_rhs = s3_rhs_r;
		s3_alumux_cin = ~s3_addsubn_r;
	end else if (s3_opcode_r == OPC_MUL16i) begin
		// Multiplier
		// s3_alumux_lhs = {{5{s3_ps0_r[PPSIZE+4-1]}},s3_ps0_r}; 
		s3_alumux_lhs = {3'b0,s3_ps0_r}; 
		s3_alumux_rhs = {s3_ps1_r,1'b0,s3_s2_r,4'b0};
		s3_alumux_cin = 1'b0;
	end else begin
		// Default
		s3_alumux_lhs = {(AL_MANSIZE+1){1'bx}};
		s3_alumux_rhs = {(AL_MANSIZE+1){1'bx}};
		s3_alumux_cin = 1'bx;
	end
end

cla_adder #(.DATA_WID(AL_MANSIZE+1)) s3_s4_u_cla(
	.in1      (s3_alumux_lhs),
	.in2      (s3_alumux_rhs),
	.carry_in (s3_alumux_cin),
	.sum      (s3_alu_out   ),
	.carry_out(             )	// Discarded
);

// ADDER: Denorm Zero: Bypass Path
reg [AL_MANSIZE:0] s3_mmux_y;
always @* begin
	case(s3_opcode_r) 
	OPC_ADDSKIP:	s3_mmux_y = s3_lhs_r;
	OPC_ADD29i:		s3_mmux_y = s3_alu_out;
	OPC_MUL16i:		s3_mmux_y = {1'b0,s3_alu_out[AL_MANSIZE-1:0]};
	endcase
end

// +------------------------------------+
// |          PIPELINE STAGE 4          |
// +------------------------------------+
// 
// General Note for S4 and S5:
//  In a regular FP Pipeline, all operations need to perform zero detect
//  and shifting. (i.e. Normalization)
// We don't need to re-normalize to the IEEE format (1.exp)
// To keep things simple, all the internal numbers are denormalized
// (0.exp) 

// UNIFIED OUTPUT STAGE: Zero Detect and EXP Bias Calculation
// Pipeline Signal Relay
reg [OPSIZE-1:0]     s4_opcode_r;
reg [AL_MANSIZE:0]   s4_many_r;		// Mantissa Y
reg [AL_EXPSIZE-1:0] s4_ea_r;		// Save Exponents for S5
reg [AL_MANSIZE-1:0] s4_eb_r;		// /
reg                  s4_ea_gte_eb_r;
reg                  s4_addsubn_r;	// Used to calculate sign
reg                  s4_sa_r;
always @(posedge clk) begin
	s4_many_r      <= s3_mmux_y;	
	s4_opcode_r    <= s3_opcode_r;
	s4_ea_r        <= s3_expa_r;
	s4_eb_r        <= s3_expb_r;
	s4_ea_gte_eb_r <= s3_ea_gte_eb_r;
	s4_addsubn_r   <= s3_addsubn_r;
	s4_sa_r        <= s3_sa_r;
end
  
// aluout is 23bits
// UNIFIED: Leading Zero Detect:
wire [4:0]  s4_lzd;		// 
wire [31:0] s4_lzdi = {s4_many_r,9'b0};
count_lead_zero #(.W_IN(32)) s4_u_lzd(.in(s4_lzdi), .out(s4_lzd));

// +------------------------------------+
// |          PIPELINE STAGE 5          |
// +------------------------------------+
// 
// UNIFIED OUTPUT STAGE: Final Shifting, Truncation, etc
// Pipeline Signal Relay
reg [OPSIZE-1:0]     s5_opcode_r;
reg                  s5_addsubn_r;	// Used to calculate sign
reg                  s5_sa_r;
always @(posedge clk) begin
	s5_opcode_r  <= s4_opcode_r;
	s5_addsubn_r <= s4_addsubn_r;
	s5_sa_r      <= s4_sa_r;
end

// UNIFIED: Final Shifter
reg [AL_MANSIZE:0] s5_many_r;
reg [4:0]          s5_lzd_r;
reg [4:0]          s5_shiftbias;
always @(posedge clk) begin
	s5_many_r    <= s4_many_r;
	s5_lzd_r     <= s4_lzd;
end

always @* begin
	if(s5_opcode_r==OPC_ADD29NORM)
		s5_shiftbias = s5_lzd_r + 1'b1;	// Also remove the hidden 1
	else
		s5_shiftbias = s5_lzd_r;		// Denorm (Default)
end

wire [31:0]        s5_bsl_out;					// The final shifter
assign dout_uni_y_man_dn = s5_bsl_out[31:10];	// Truncate to 22 bits
bsl #(.SWIDTH(5)) s5_u_bsl (
	.din    ({s5_many_r,9'b0}),
	.s      (s5_shiftbias     ),
	.filler (1'b0             ),
	.dout   (s5_bsl_out       )
);

// UNIFIED: Exponent Adjust
// Signal Relay
reg [AL_EXPSIZE-1:0] s5_ea_r;
reg [AL_EXPSIZE-1:0] s5_eb_r;
reg                  s5_ea_gte_eb_r;
wire                 s5_ea_lt_eb = ~s5_ea_gte_eb_r;
always @(posedge clk) begin
	s5_ea_r        <= s4_ea_r;
	s5_eb_r        <= s4_eb_r;
	s5_ea_gte_eb_r <= s4_ea_gte_eb_r;
end
wire [AL_EXPSIZE-1:0] s5_expadj_skip = 0;
wire [AL_EXPSIZE:0]   s5_expadj_mul;
wire [AL_EXPSIZE:0]   s5_expadj_add;
reg  [AL_EXPSIZE:0]   s5_expadj_final;
reg                   s5_sign_final;
// MULTIPLY: Re-bias exponents to AL_EXPBIAS
assign s5_expadj_mul  = {1'b0,s5_ea_r} + {1'b0,s5_eb_r} - 2*ML_EXPBIAS + AL_EXPBIAS + 1;
// ADDER: Use the larger exponent
assign s5_expadj_add  = s5_ea_gte_eb_r ?  {1'b0,s5_ea_r} : {1'b0,s5_eb_r};
always @* begin
	if(s5_opcode_r == OPC_ADD29i) begin				// ADD29i
		s5_expadj_final = s5_expadj_add + 2 - s5_lzd_r;
		if(s5_addsubn_r)	s5_sign_final = s5_sa_r;
		else				s5_sign_final = s5_ea_lt_eb ^ s5_sa_r;
	end else if (s5_opcode_r == OPC_MUL16i) begin	// MUL16i 
		s5_expadj_final = s5_expadj_mul + 2 - s5_lzd_r;
		s5_sign_final   = ~s5_addsubn_r;			
	end else if (s5_opcode_r == OPC_ADDSKIP) begin	// Pass Thru
		s5_expadj_final = {1'b0, s5_expadj_skip};
	end else begin
		s5_expadj_final = s5_expadj_add - s5_lzd_r + 1;
	end	
end

// TODO: Deal with exponent overflow using the extra bit
assign dout_uni_y_exp = s5_expadj_final[AL_EXPSIZE-1:0];
assign dout_uni_y_sgn = s5_sign_final;

endmodule /* FPALU */

// Congrats on 500 Lines total :-D
/* vim: set ts=4 sw=4 noet */
