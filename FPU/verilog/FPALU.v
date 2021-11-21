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
localparam ML_EXPSIZE = 3;
localparam ML_FPSIZE  = 1 + ML_EXPSIZE + ML_MANSIZE;
localparam AL_MANSIZE = 2 * ML_MANSIZE;
localparam AL_EXPSIZE = 1 + ML_EXPSIZE;
localparam AL_FPSIZE  = 1 + AL_EXPSIZE + AL_MANSIZE;


// ----- PIPELINE STAGE 2 ----- 
// ADDER SECTION
// Task 1: Shift & Mantissa Inversion
reg  [6:0] s2_ea_sub_eb_r;
reg  [5:0] s2_ea_sub_eb_abs_r;  // Absolute Value, for the shifter
// reg        s2_ea_gt_eb_r;
reg        s2_exp_largediff_r;  // Deactivate the shifter
reg        s2_addsub_r;
reg        s2_xchg_r;           // Exchange Addsub Input
always @(posedge clk) begin
	s2_ea_sub_eb_r     <= s1_ea_sub_eb;
	s2_ea_sub_eb_abs_r <= s1_ea_sub_eb_abs;
	// s2_ea_gt_eb_r      <= s1_ea_gt_eb;
	s2_exp_largediff_r <= s1_exp_largediff;
	s2_addsub_r        <= s1_addsub;
	s2_xchg_r          <= s1_xchg;
end

// Operand MUX
reg  [21:0] s2_mmux21_larger_r;
reg  [21:0] s2_mmux22_smaller_r;
always @(posedge clk) begin
	if(s1_ea_gt_eb) begin
		s2_mmux21_larger  <= din_uni_a_man_dn;
		if(s1_exp_largediff) // Keep & Bypass
			s2_mmux22_smaller_r <= s2_mmux22_smaller_r;
		else                 // Update
			s2_mmux21_smaller_r <= din_uni_b_man_dn;
	end else begin
		s2_mmux21_larger  <= din_uni_b_man_dn;         
		if(s1_exp_largediff) // Keep & Bypass
			s2_mmux22_smaller_r <= s2_mmux22_smaller_r;
		else                 // Update
			s2_mmux21_smaller_r <= din_uni_a_man_dn;
	end
end

// Shifter & Mantissa Inversion Implementation
reg [21:0] s2_mmux23_smaller_preinv;    // Zero Add Sub MUX  
reg [21:0] s2_mmux24_smaller_out;       // Mantissa Inversion MUX
always @* begin
	if(s2_exp_largediff_r) s2_mmux23_smaller_preinv = 0;
	else                   s2_mmux23_smaller_preinv = {{s2_mmux21_smaller_r,22'b0}>>(s2_ea_sub_eb_abs_r)}[21:0];
	if(~s2_addsub_r) s2_mmux24_smaller_out = ~s2_mmux23_smaller_preinv;
	else             s2_mmux24_smaller_out =  s2_mmux23_smaller_preinv;
end

// ----- PIPELINE STAGE 3 ----- 
// PIPELINE RELAY
reg  [6:0] s3_ea_sub_eb_r;
reg        s3_ea_gt_eb_r;
reg        s3_addsub_r;

always @(posedge clk) begin
	s3_addsub_r <= s2_addsub_r;

end


// Section: Adder

// Input Exchanger: ManY = A ± B
reg [21:0]  s3_mmux3_a_r;
reg [21:0]  s3_mmux3_b_r;
always @(posedge clk) begin
	if(s2_xchg_r) begin
		if(s2_ea_gt_eb_r) begin
			// A is in the larger_r, B is in the smaller_r
			s3_mmux3_a_r <= s2_mmux21_larger_r;
			s3_mmux3_b_r <= s2_mmux24_smaller_out;  
		end else begin
			// B is in the larger_r, A is in the smaller_r
			s3_mmux3_b_r <= s2_mmux21_larger_r;
			s3_mmux3_a_r <= s2_mmux24_smaller_out;  
		end
	end else begin
		if(s2_ea_gt_eb_r) begin
			// A is in the larger_r, B is in the smaller_r
			s3_mmux3_b_r <= s2_mmux21_larger_r;
			s3_mmux3_a_r <= s2_mmux24_smaller_out;  
		end else begin
			// B is in the larger_r, A is in the smaller_r
			s3_mmux3_a_r <= s2_mmux21_larger_r;
			s3_mmux3_b_r <= s2_mmux24_smaller_out;  
		end        
	end
end

// Addsub Implementation
wire [22:0]  s3_many_out;
wire         s3_cin;
assign s3_cin = ~s3_addsub_r;
assign s3_many_out = {s3_mmux3_a_r[21], s3_mmux3_a_r} + {s3_mmux3_b_r[21], s3_mmux3_b_r} + s3_cin;


// ----- PIPELINE STAGE 1 -----
//
wire s1_opcode;

// ADDER: Exponent Compare
wire [AL_EXPSIZE:0]   s1_ea_sub_eb = {1'b0,din_uni_a_exp} - {1'b0,din_uni_b_exp};
wire                  s1_ea_lt_eb  = s1_ea_sub_eb[AL_EXPSIZE];
wire                  s1_ea_gte_eb  = s1_ea_lt_eb;
wire [AL_EXPSIZE-1:0] s1_ea_sub_eb_abs = s1_ea_gt_eb ? \
		s1_ea_sub_eb[AL_EXPSIZE-1:0] : {~s1_ea_sub_eb+1'b1}[AL_EXPSIZE-1:0];
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


// ----- PIPELINE STAGE 2 -----
//
// Pipeline Signal Relay
reg                  s2_opcode_r;
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
	s2_mmux_lhs_r      <= s1_mmux_lhs_r;
	s2_mmux_rhs_r      <= s2_mmux_rhs_r;
	s2_addsubn_r       <= s1_addsubn;
end

// ADDER: Shifter
// When shifting by [MSB], the output becomes zero
wire [31:0]	s2_bsr_out;
wire [AL_MANSIZE-1:0] s2_bsr_out_gated = s2_ea_sub_eb_abs_r[AL_EXPSIZE-1] ? \
		{AL_MANSIZE{1'b0}} : s2_bsr_out[31:32-AL_MANSIZE];
bsr #(.SWIDTH(AL_EXPSIZE-1)) s2_u_bsr(
	.din(s2_mmux_rhs_r),
	.s(s2_ea_sub_eb_abs_r[AL_EXPSIZE-2:0]),
	.filler(1'b0),
	.dout(s2_bsr_out)
);

// ADDER: Exchanger & Inverter
//
wire [AL_MANSIZE:0]   s2_mmux2_lhs;
wire [AL_MANSIZE-1:0] s2_mmux2_rhs;
xchg #(.DWIDTH(AL_MANSIZE)) s2_u_manxchg(
	.ia(s2_mmux_lhs_r),
	.ib(s2_bsr_out_gated),
	.xchg(~s2_ea_gte_eb_r),
	.oa(s2_mmux2_lhs[AL_MANSIZE-1:0]),
	.ob(s2_mmux2_rhs)
);

assign s2_mmux2_lhs[AL_MANSIZE] = 1'b0;
wire [AL_MANSIZE:0]   s2_mmux3_rhs_addsub = s2_addsubn_r ? \
	s2_mmux2_rhs : ~s2_mmux2_rhs;

// ----- PIPELINE STAGE 3 -----
//
// SEGMENT 1. Pipeline Signal Relay
reg  s3_opcode_r;
always @(posedge clk) begin
	s3_opcode_r <= s2_opcode;
end

// ADDER: Summing (CLA)

// ----- PIPELINE STAGE 4 -----
// UNIFIED OUTPUT STAGE: Zero Detect and EXP Bias Calculation
// SEGMENT 1. Pipeline Signal Relay
reg  s4_opcode_r;
always @(posedge clk) begin
	s4_opcode_r <= s3_opcode;

end


// Leading Zero Detect:


// ----- PIPELINE STAGE 5 -----
// UNIFIED OUTPUT STAGE: Final Shifting, Truncation, etc
// SEGMENT 1. Pipeline Signal Relay
reg  s5_opcode_r;
always @(posedge clk) begin
	s5_opcode_r <= s4_opcode;

end


endmodule /* FPALU */

