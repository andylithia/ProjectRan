// Misc Building Blocks
// Anhang Li Nov.19 2021

`timescale 1ns/1ps

// Exchanger
module xchg #(
	parameter DWIDTH = 32
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
		assign temp[gi+1] = s[gi] ? {{(2**gi){filler}},temp[gi]>>(2**gi)} : temp[gi];
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
	for(gi=0;gi<SWIDTH;gi=gi+1) begin : gen_blshift
		assign temp[gi+1] = s[gi] ? {temp[gi],{(2**gi){filler}}} : temp[gi];
	end
endgenerate

endmodule   /* bsl */

/*
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
	if (W_IN > 2) begin : gen_recurse
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
	end else begin : gen_terminal
		assign out = !in[1];
	end
endgenerate

endmodule /* count_lead_zero */

module booth_enc_r4(
	input      [2:0]	bin,
	output reg [2:0]	br4_out
);

localparam  BOOTH_0  = 3'b000;
localparam  BOOTH_P1 = 3'b001;
localparam  BOOTH_P2 = 3'b010;
localparam  BOOTH_N1 = 3'b111;
localparam  BOOTH_N2 = 3'b110;

always @* begin
	br4_out = 3'bxxx;
	case(bin)
		3'b000: br4_out = BOOTH_0;
		3'b001: br4_out = BOOTH_P1;
		3'b010: br4_out = BOOTH_P1;
		3'b011: br4_out = BOOTH_P2;
		3'b100: br4_out = BOOTH_N2;
		3'b101: br4_out = BOOTH_N1;
		3'b110: br4_out = BOOTH_N1;
		3'b111: br4_out = BOOTH_0;
	endcase
end

endmodule

// fpga4student.com FPGA projects, Verilog projects, VHDL projects 
// Verilog code for carry look-ahead adder
module cla_adder #(
	parameter DATA_WID = 32
)(
	input wire  [DATA_WID - 1:0]  in1,
	input wire  [DATA_WID - 1:0]  in2,
	input wire                    carry_in,
	output wire [DATA_WID - 1:0]  sum,
	output wire                   carry_out
);
	//assign {carry_out, sum} = in1 + in2 + carry_in;
	wire [DATA_WID - 1:0] gen;
	wire [DATA_WID - 1:0] pro;
	wire [DATA_WID:0] carry_tmp;
	genvar j, i;
	generate
		//assume carry_tmp in is zero
		assign carry_tmp[0] = carry_in;
		//carry generator
		for(j = 0; j < DATA_WID; j = j + 1) begin: carry_generator
			assign gen[j] = in1[j] & in2[j];
			assign pro[j] = in1[j] | in2[j];
			assign carry_tmp[j+1] = gen[j] | pro[j] & carry_tmp[j];
		end 
		//carry out 
		assign carry_out = carry_tmp[DATA_WID];
		//calculate sum 
		//assign sum[0] = in1[0] ^ in2 ^ carry_in;
		for(i = 0; i < DATA_WID; i = i+1) begin: sum_without_carry
			assign sum[i] = in1[i] ^ in2[i] ^ carry_tmp[i];
		end 
	endgenerate 
endmodule

// Radix-4 Booth Partial Product Generator
module booth_ppgen_r4 #(
	parameter DWIDTH = 11
)(
	input [DWIDTH-1:0]			a,
	input [2:0]					br4,
	output reg [DWIDTH:0]		o,
	output                      s
);
	assign s = br4[2];
	always @* begin
		o = {(DWIDTH){1'bx}};
		case(br4)
		3'b000: o = 0;
		3'b001:	o = {1'b0,a};
		3'b010: o = {a,1'b0};
		3'b111:	o = {1'b1,~a};
		3'b110: o = {~a,1'b1};
		endcase
	end
endmodule /* booth_ppgen_r4 */
