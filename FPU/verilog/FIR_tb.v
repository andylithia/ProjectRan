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

integer fp_output;
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
	fp_output = $fopen("output.txt","w+");
    $dumpfile("W4823_FIR_tb.vcd");
    $dumpvars(0,W4823_FIR_tb);
	#15000000
	$fclose(fp_output);
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
	real       din_real;
	reg [10:0] din_man_dn;
	always @(posedge clk_slow or negedge rst_n) begin
		if(din[14:10]==0) begin
			$display("DIN DENORM @ %Xh",daddr);
			din_man_dn = {din[9:0], 1'b0};
		end else
			din_man_dn = {1'b1,din[9:0]};
		din_real = (1.0-2.0*din[15]) * din_man_dn * 2.0**(-10.0) * 2.0**(din[14:10]-15.0);
		
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

wire [28:0] dout_raw;

W4823_FIR dut (
    .rst_n    (rst_n   ),
    .clk_slow (clk_slow),
    .clk      (clk_fast),
    .din      (din     ),
    .valid_in (1'b0    ),
    .cin      (cin     ),
    .caddr    (caddr   ),
    .cload    (cload   ),
    .dout_29i (dout_raw),
    .valid    (        )
);

real dout_real;
always @(posedge clk_fast) begin
	if(clk_div==8'h12) begin
		dout_real = (1.0-2.0*dout_raw[28]) * dout_raw[21:0] * 2.0**(-21.0 + dout_raw[27:22] - 31.0);
		$fwrite(fp_output,"%e\n",dout_real);
	end
end


endmodule /* W4823_FIR_tb */

/* vim: set ts=4 sw=4 noet */
