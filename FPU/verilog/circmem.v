// Circular Buffer as the FIR input buffer
// Anhang Li, Nov 19, 2021

`timescale 1ns/1ps
module fir_circmem #(
	parameter DWIDTH     = 16,		// FP16 Data
	parameter AWIDTH     = 6,		// 64-Elements
	parameter RST_USEFUL = 0,		// when =0, the reset lines are not implemented, which reduces impl. overhead
)(
	input					rst_n,
	input					clk,		// 10kHz Data clock
	input					clk_64x,	// 640kHz Readout Clock
	input  [DWIDTH-1:0]		din,
	output reg [DWIDTH-1:0]	dout,
	output					drdy
);

reg [AWIDTH-1:0] addr_wr_r;
reg [AWIDTH-1:0] addr_rd_r;

assign drdy = addr_wr_r == 0;

// Consider replacing this part with a Memcompiler memory block
// Dual port? not really necessary
reg [DWIDTH-1:0] mem [(2**AWIDTH)-1:0];

generate 
	if(RST_USEFUL) begin : gen_circmem_has_rst
		integer j; 
		always @(posedge clk_64x or negedge rst_n) begin
			if(~rst_n)
				for(j=0;j<2**AWIDTH;j=j+1)
					mem[j] <= {DWIDTH{1'b0}};
			else begin
				// memory I/O
				mem[addr_wr_r] <= din;
				dout <= mem[addr_rd_r];
			end
		end
	end else begin : gen_circmem_no_rst
		always @(posedge clk) begin
			mem[addr_wr_r] <= din;
			dout <= mem[addr_rd_r];
		end
	end
endgenerate

always @(posedge clk or negedge rst_n) begin
	if(~rst_n)	addr_wr_r <= 0;
	else		addr_wr_r <= addr_wr_r + 1;
end

always @(posedge clk_64x or negedge rst_n) begin
	if(~rst_n)	addr_rd_r <= 0;
	else		addr_rd_r <= addr_rd_r + 1;
end

endmodule /* fir_circmem */
