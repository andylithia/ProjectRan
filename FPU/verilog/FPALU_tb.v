// FPALU TB
// A.L. - Nov. 27 2021

// Excite the ALU with some randomly generated binary data
// To verify the output, use python script.

`timescale 1ns/1ps

module FPALU_tb();
	reg [31:0] a;
	reg [31:0] b;

	//Built in real for verification of code
	real      result;
	reg       clk;
	reg       rst_n;
	reg [1:0] opcode;
  
	wire          din_uni_a_sgn    = a[28];
	wire [5:0]    din_uni_a_exp    = a[27:22];
	wire [21:0]   din_uni_a_man_dn = a[21:0];
	wire          din_uni_b_sgn    = b[28];
	wire [5:0]    din_uni_b_exp    = b[27:22];
	wire [21:0]   din_uni_b_man_dn = b[21:0];
	wire          dout_uni_y_sgn;
	wire [5:0]    dout_uni_y_exp; 
	wire [21:0]   dout_uni_y_man_dn;

	reg [8:0] daddr;
	reg [5:0] caddr;
	wire [15:0] cin;
	wire [15:0] din;
	data_cmem_fp16 u_cmem_src(
		.a(caddr),
		.q(cin)
	);

	data_dmem_fp16 u_dmem_src(
		.a(daddr),
		.q(din)
	);

	`define DEBUGINFO
	FPALU dut(
		.clk(clk), .opcode(opcode),
		.din_uni_a_sgn     (din_uni_a_sgn    ),
		.din_uni_a_exp     (din_uni_a_exp    ),
		.din_uni_a_man_dn  (din_uni_a_man_dn ),
		.din_uni_b_sgn     (din_uni_b_sgn    ),
		.din_uni_b_exp     (din_uni_b_exp    ),
		.din_uni_b_man_dn  (din_uni_b_man_dn ),
		.dout_uni_y_sgn    (dout_uni_y_sgn   ),
		.dout_uni_y_exp    (dout_uni_y_exp   ),
		.dout_uni_y_man_dn (dout_uni_y_man_dn)
	);
	
	integer i;
	real dout_real;
	initial begin
		a = {$random};
		b = {$random};
		clk    = 0;
		caddr  = 0;
		daddr  = 0;

		#331;
		
		$dumpfile("dump.vcd");
		$dumpvars;
		#331 clk = 1;

		// Multiplier Test
		opcode = 2'b10;	// MUL16i
		for(i=0;i<200;i=i+1) begin
			#331 clk = 0;
			caddr = caddr + 1;
			daddr = daddr + 1;
			a = {din[15], 1'b0, din[14:10], 12'b0, din[9:0]};
			b = {cin[15], 1'b0, cin[14:10], 12'b0, cin[9:0]};
			#331 clk = 1;
			dout_real = (1.0-2.0*dout_uni_y_sgn) * dout_uni_y_man_dn * 2.0**(-21.0 + dout_uni_y_exp - 31.0);
		end

		// Adder test
		opcode = 2'b11;	// ADD29i
		for(i=0;i<200;i=i+1) begin
			#331 clk = 0;
			a = {$random};
			b = {$random};
			#331 clk = 1;
		end
		$finish;
	end
endmodule /* FPALU_tb */ 
/* vim: set ts=4 sw=4 noet */
