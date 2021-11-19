// circmem_tb.v
// Testbench for the circular buffer
// A.L. Nov.19

`timescale 1ns/1ps

module circmem_tb();

reg [5:0] tb_clkdiv_64;
reg       tb_clk_64;		// 64x clock (1 MHz)
wire      tb_clk;
wire      tb_clk_neg;		// 1/64 clock (15.625 kHz)
reg       tb_rstn;

// ---- CLOCK GENERATOR ----
assign tb_clk     = tb_clkdiv_64[6];
assign tb_clk_neg = ~tb_clk;

always @(posedge tb_clk_64 or negedge tb_rstn) begin
	if(~tb_rstn) 
		tb_clkdiv_64 <= 6'b0;
	else
		tb_clkdiv_64 <= tb_clkdiv_64 + 1;
end

always #500 tb_clk_64 = ~tb_clk_64;

// ---- NUMBER GENERATOR ----

localparam DWIDTH = 16;
localparam AWIDTH = 6;
reg [DWITH-1:0] tb_din;
always @(posedge tb_clk or negedge tb_rstn) begin
	if(~tb_rstn)	tb_din <= 0;
	else			tb_din <= tb_din + 1;
end

wire [DWIDTH-1:0] dut_dout;
wire              dut_drdy;

// ---- INSTANCE ----
fir_circmem dut(
	.rst_n(tb_rstn),
	.clk(tb_clk_neg),
	.clk_64x(tb_clk_64),
	.din(tb_din),
	.dout(dut_dout),
	.drdy(dut_drdy)
);


endmodule /* circmem_tb */