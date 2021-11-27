// FPALU TB
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
	wire [5:0]    din_uni_a_exp    = {1'b1,a[26:22]};
	reg  [21:0]   din_uni_a_man_dn;
	wire          din_uni_b_sgn    = b[28];
	wire [5:0]    din_uni_b_exp    = b[27:22];
	reg  [21:0]   din_uni_b_man_dn;
	wire          dout_uni_y_sgn;
	wire [5:0]    dout_uni_y_exp; 
	wire [21:0]   dout_uni_y_man_dn;

	always @* begin
		if(opcode==2'b10) begin
			din_uni_a_man_dn = a[21:0];
			din_uni_b_man_dn = b[21:0];
		end else begin
			din_uni_a_man_dn = {1'b1,a[20:0]};	// Force norm
			din_uni_b_man_dn = {1'b1,b[20:0]};	// Force norm
		end
	end

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
	initial begin
		a = {$random};
		b = {$random};
		opcode = 2'b11;	// ADD29i
		clk    = 0;
		#1;
		
		$dumpfile("dump.vcd");
		$dumpvars;
		#1 clk = ~clk;

		// Adder test
		for(i=0;i<200;i=i+1) begin
			#1 clk = ~clk;
			a = {$random};
			b = {$random};
			#1 clk = ~clk;
		end

		// Multiplier Test
		opcode = 2'b10;	// MUL16i
		for(i=0;i<200;i=i+1) begin
			#1 clk = ~clk;
			a = {$random};
			b = {$random};
			#1 clk = ~clk;
		end
		$finish;
	end

endmodule /* FPALU_tb */ 
/* vim: set ts=4 sw=4 noet */