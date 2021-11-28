`timescale 1ns/1ps
module FPALU_dummy (
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

reg        as_s2_r;
reg [5:0]  ae_s2_r;
reg [21:0] am_s2_r;

reg        bs_s2_r;
reg [5:0]  be_s2_r;
reg [21:0] bm_s2_r;

reg        as_s3_r;
reg [5:0]  ae_s3_r;
reg [21:0] am_s3_r;

reg        bs_s3_r;
reg [5:0]  be_s3_r;
reg [21:0] bm_s3_r;

reg        as_s4_r;
reg [5:0]  ae_s4_r;
reg [21:0] am_s4_r;

reg        bs_s4_r;
reg [5:0]  be_s4_r;
reg [21:0] bm_s4_r;

reg        as_s5_r;
reg [5:0]  ae_s5_r;
reg [21:0] am_s5_r;

reg        bs_s5_r;
reg [5:0]  be_s5_r;
reg [21:0] bm_s5_r;

always @(posedge clk) begin
	as_s2_r <= din_uni_a_sgn;
	ae_s2_r <= din_uni_a_exp;
	am_s2_r <= din_uni_a_man_dn;
	bs_s2_r <= din_uni_b_sgn;
	be_s2_r <= din_uni_b_exp;
	bm_s2_r <= din_uni_b_man_dn;

	as_s3_r <= as_s2_r;
	ae_s3_r <= ae_s2_r;
	am_s3_r <= am_s2_r;
	bs_s3_r <= bs_s2_r;
	be_s3_r <= be_s2_r;
	bm_s3_r <= bm_s2_r;
	
	as_s4_r <= as_s3_r;
	ae_s4_r <= ae_s3_r;
	am_s4_r <= am_s3_r;
	bs_s4_r <= bs_s3_r;
	be_s4_r <= be_s3_r;
	bm_s4_r <= bm_s3_r;
	
	as_s5_r <= as_s4_r;
	ae_s5_r <= ae_s4_r;
	am_s5_r <= am_s4_r;
	bs_s5_r <= bs_s4_r;
	be_s5_r <= be_s4_r;
	bm_s5_r <= bm_s4_r;	
end

assign dout_uni_y_sgn = as_s5_r ^ bs_s5_r;
assign dout_uni_y_exp = {1'b0, ae_s5_r} + {1'b0, be_s5_r};
assign dout_uni_y_man_dn = {6'b0, am_s5_r[7:0], bm_s5_r[7:0]};

endmodule /* FPALU_dummy */
/* vim: set ts=4 sw=4 noet */