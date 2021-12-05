// FIR topmodule Testbench
// 1. Write CMEM
// 2. Generate Din
// 3. Record Dout
// A.L. - Nov. 27 2021

`timescale 1ns/1fs
module W4823_FIR_tb;

`define USE_REAL_DATA
`define DEBUGINFO

reg         rst_n;
reg         clk_fast;
reg [7:0]   clk_div;
wire        clk_slow = clk_div[7];    // 10kHz
reg         first_cycle_r;

// CMEM Writer
integer     load_cmem_cnt_r;
wire        cload;
reg  [5:0]  caddr;
wire [15:0] cin;
// Din Writer
reg [8:0]   daddr;
wire [15:0] din;


always @(posedge clk_fast or negedge rst_n) begin
   if(~rst_n) clk_div = 7'b1111111;
   else       clk_div = clk_div + 1'b1; 
end

initial begin
    rst_n = 1;
    clk_fast = 0;
	first_cycle_r = 1;
	caddr = 0;
	daddr = 0;
	load_cmem_cnt_r = 0;

    #100 rst_n = 0;
    #100 rst_n = 1;
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

assign cload = (~clk_fast) & (load_cmem_cnt_r<65);
`ifdef USE_REAL_DATA
	// CMEM Writer
	always @(posedge clk_fast) begin
		if(load_cmem_cnt_r<65) begin
			if(cin[14:10]==0) $display("CIN DENORM @ %Xh", caddr);
			caddr           <= caddr + 1;
			load_cmem_cnt_r <= load_cmem_cnt_r + 1;
			// Assuming 16bit FP16
		end
	end
	// Din Writer
	always @(posedge clk_slow or negedge rst_n) begin
		if(din[14:10]==0) $display("DIN DENORM @ %Xh",daddr);
		if(~rst_n) daddr <= 0;
		else       daddr <= daddr + 1;
	end
	data_cmem_fp16 u_cmem_src(.a(caddr),.q(cin));
	data_dmem_fp16 u_dmem_src(.a(daddr),.q(din));
`else
	// CMEM Writer
	assign cin = {10'b0011110000,caddr};
	always @(posedge clk_fast) bvegin
		if(load_cmem_cnt_r<65) begin
			caddr <= caddr + 1;
			// cin <= {$random};
			load_cmem_cnt_r = load_cmem_cnt_r + 1;
		end
	end
	// Din Writer
	assign din = {7'b0011110,daddr};
	always @(posedge clk_slow or negedge rst_n) begin
		if(~rst_n) daddr <= 0;
		else       daddr <= daddr + 1;
	end
`endif /* USE_REAL_DATA */

W4823_FIR dut (
    .rst_n    (rst_n   ),
    .clk_slow (clk_slow),
    .clk      (clk_fast),
    .din      (din     ),
    .valid_in (1'b0    ),
    .cin      (cin     ),
    .caddr    (caddr   ),
    .cload    (cload   ),
    .dout     (        ),
    .valid    (        )
);

endmodule /* W4823_FIR_tb */

/* vim: set ts=4 sw=4 noet */
