
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

reg [DATA_WIDTH-1:0] mem [DEPTH];
always @(posedge clk) begin
	if(wr) begin
		mem[addr] <= din;
		qout      <= {DATA_WIDTH{1'bx}};
	end else 
		qout      <= mem[addr];
end

endmodule /* sp_sram */
/* vim: set ts=4 sw=4 noet */