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

// Parametrized Barrel Shifter : Right Shift
module bsr #(
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

endmodule   /* bsr */

// Parametrized Barrel Shifter: Left Shift
module bsl #(
	parameter SWIDTH = 5
)(
	input [(2**SWIDTH)-1:0]     din,
	input [SWIDTH-1:0]          s,
	input                       filler, // 0: SLL Logic  Shift Left
	output [(2**SWIDTH)-1:0]    dout
);

wire [(2**SWIDTH)-1:0]	temp [SWIDTH:0];

assign temp[0] = din;
assign dout    = temp[SWIDTH];

genvar gi;
generate
	for(gi=0;gi<SWIDTH;gi=gi+1) begin : gen_brshift
		assign temp[gi+1] = s[gi] ? \
			{temp[gi]<<(2**gi),{(2**gi){filler}}} : temp[gi];
	end
endgenerate

endmodule   /* bsl */

module bsr_tb;
    reg [31:0] din;
    reg [4:0]  s;
    wire [31:0] dout;
    bsr #(.SWIDTH(32)) dut(
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

// Counting Lead Zero using a tree structure
// https://electronics.stackexchange.com/questions/196914/verilog-synthesize-high-speed-leading-zero-count
module count_lead_zero #(
    parameter W_IN = 32,           // Must be power of 2, >=2
    parameter W_OUT = $clog2(W_IN) // Let this default
) (
    input wire  [W_IN-1:0] in,
    output wire [W_OUT-1:0] out
);

generate
	if (W_IN == 2) begin : gen_base
		assign out = !in[1];
	end else begin : gen_recurse
		wire [W_OUT-2:0] half_count;
		wire [W_IN / 2-1:0] lhs = in[W_IN / 2 +: W_IN / 2];
		wire [W_IN / 2-1:0] rhs = in[0        +: W_IN / 2];
		wire left_empty = ~|lhs;

		count_lead_zero #(
			.W_IN (W_IN / 2)
		) inner (
			.in  (left_empty ? rhs : lhs),
			.out (half_count)
		);
		assign out = {left_empty, half_count};
	end
endgenerate

endmodule /* count_lead_zero */


