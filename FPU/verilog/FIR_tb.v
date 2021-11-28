`timescale 1ns/1fs
/*
module W4823_FIR(
	input           rst_n,		//
	input           clk1,		// Slow Clock 
	input           clk2,		// Fast Clock
	input [15:0]    din,		// FP16 Input Data
	input           valid_in,	// Input Ready
	input [16:0]    cin,		// Coefficient Input
	input [5:0]     caddr,		// Coefficient Address (64)
	input           cload,
	output [15:0]   dout,		// FP16 Output Data
	output          valid		// Output Ready
);
*/
module W4823_FIR_tb;

reg       rst_n;
reg       clk_fast;
reg [7:0] clk_div;
wire      clk_slow = clk_div[7];    // 10kHz

always @(posedge clk_fast or negedge rst_n) begin
   if(~rst_n) clk_div = 7'b1111111;
   else       clk_div = clk_div + 1'b1; 
end

initial begin
    $dumpfile("W4823_FIR_tb.vcd");
    $dumpvars(0,W4823_FIR_tb);
    rst_n = 1;
    clk_fast = 0;
    #1 rst_n = 0;
    #1 rst_n = 1;
    #193.3125 clk_fast = 1;
    //#100000
	#250000
    $finish;
end

always #195.3125 clk_fast = ~clk_fast;

W4823_FIR dut (
    .rst_n(rst_n),
    .clk1(clk_slow),
    .clk2(clk_fast),
    .din(16'b0),
    .valid_in(1'b0),
    .cin(17'b0),
    .caddr(6'b0),
    .cload(1'b0),
    .dout(),
    .valid()
);

endmodule /* W4823_FIR_tb */

/* vim: set ts=4 sw=4 noet */