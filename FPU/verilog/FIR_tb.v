// FIR topmodule Testbench
// 1. Write CMEM
// 2. Generate Din
// 3. Record Dout
// A.L. - Nov. 27 2021

`timescale 1ns/1fs
module W4823_FIR_tb;

reg       rst_n;
reg       clk_fast;
reg [7:0] clk_div;
wire      clk_slow = clk_div[7];    // 10kHz
reg       first_cycle_r;

reg [5:0]  caddr;
reg [16:0] cin;
wire       cload;
integer    load_cmem_cnt_r;

reg [15:0] din;


always @(posedge clk_fast or negedge rst_n) begin
   if(~rst_n) clk_div = 7'b1111111;
   else       clk_div = clk_div + 1'b1; 
end

initial begin
    rst_n = 1;
    clk_fast = 0;
	first_cycle_r = 1;
	caddr = 0;
	load_cmem_cnt_r = 0;
	din = 0;

    #1 rst_n = 0;
    #1 rst_n = 1;
    #193.3125 clk_fast = 1;
    //#100000
	// #10000000
	#6420000
    $dumpfile("W4823_FIR_tb.vcd");
    $dumpvars(0,W4823_FIR_tb);
	#150000
	$finish;
end

always #195.3125 clk_fast = ~clk_fast;

// CMEM Writer
assign cload = (~clk_fast) & (load_cmem_cnt_r<65);
always @(posedge clk_fast) begin
	if(load_cmem_cnt_r<65) begin
		caddr <= caddr + 1;
		cin <= {$random};
		load_cmem_cnt_r = load_cmem_cnt_r + 1;
	end
end

// Din Writer
always @(posedge clk_slow) begin
	din <= din + 1;
end

W4823_FIR dut (
    .rst_n(rst_n),
    .clk1(clk_slow),
    .clk2(clk_fast),
    .din(din),
    .valid_in(1'b0),
    .cin(cin),
    .caddr(caddr),
    .cload(cload),
    .dout(),
    .valid()
);

endmodule /* W4823_FIR_tb */

/* vim: set ts=4 sw=4 noet */