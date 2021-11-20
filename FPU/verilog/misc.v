// Misc Building Blocks
// Anhang Li Nov.19 2021

// Exchanger
module xchg #(
	parameter DWIDTH = 32;
)(
	input [DWIDTH-1:0]  ia,
	input [DWIDTH-1:0]  ib,
	input               xchg,
	output [DWIDTH-1:0] oa,
	output [DWIDTH-1:0] ob
);

assign oa = xchg ? ib : ia;
assign ob = xchg ? ia : ib;

endmodule /* xchg */

// Parametrized Barrel Shifter
module brshift #(
	parameter SWIDTH = 5
)(
	input [(2**SWIDTH)-1:0]     din,
	input [SWIDTH-1:0]          s,
	input                       filler, // 0:        SRL Logic  Shift Right
										// din[MSB]: SRA Arith. Shift Right (preserve sign)
	output [(2**SWIDTH)-1:0]    dout
);

wire [(2**SWIDTH)-1:0]	temp [SWIDTH:0];

assign temp[0] = din;
assign dout    = temp[SWIDTH];

genvar gi;
generate
	for(gi=0;gi<SWIDTH;gi=gi+1) begin : gen_brshift
    assign temp[gi+1] = s[gi] ? \
		{{(2**gi){filler}},temp[gi]>>(2**gi)} : temp[gi];
	end
endgenerate

endmodule   /* brshift */

module brshift_tb;
    reg [31:0] din;
    reg [4:0]  s;
    wire [31:0] dout;
    brshift dut(
        .din(din),
        .s(s),
        .filler(1'b0),
        .dout(dout)
    );
  initial 
    begin
        din = 32'hDEADBEEF;
        s   = 31;
        #1
        $display("%d,%d,%d,%d",din,s,din>>s,dout);
    end
endmodule /* brshift_tb */


