// Implementation of a behavioural SRAM
// For the W4823 FIR Project
// Anhang Li - Nov. 27 2021

`timescale 1ns/1fs
module sp_sram #(
	parameter ADDR_WIDTH = 4,
	parameter DATA_WIDTH = 16,
	parameter DEPTH = 2**ADDR_WIDTH   
)(
	input                       clk,
	input [ADDR_WIDTH-1:0]      addr,
	input [DATA_WIDTH-1:0]      din,
	input                       wr,
	output reg [DATA_WIDTH-1:0] qout
);

reg [DATA_WIDTH-1:0] mem [DEPTH-1:0];
always @(posedge clk) begin
	if(wr) begin
		mem[addr] <= din;
		qout      <= {DATA_WIDTH{1'bx}};
	end else 
		qout      <= mem[addr];
end

endmodule /* sp_sram */
/* vim: set ts=4 sw=4 noet */
