// Integer 5-Stage ALU Behavioural Model
// Used to test the sanity of our FIR topmodule
// A.L. Dec.2.2021


// 16*16 -> 32
//          32 16  8  4  2
// 32*64 -> 33 34 35 36 37 38
module IALU #(
	parameter DWIDTH = 16
)(
	input								clk,
	input [2:0]							opcode,	
	input [DWIDTH*2+6-2:0]				A,
	input [DWIDTH*2+6-2:0]				B,
	output reg [DWIDTH*2+6-1:0]			Y
);

localparam IDWIDTH = DWIDTH*2+6-1;

reg [IDWIDTH-1:0] s2_a_r;
reg [IDWIDTH-1:0] s2_b_r;
reg [1:0]         s2_opcode_r;
reg [IDWIDTH-1:0] s3_a_r;
reg [IDWIDTH-1:0] s3_b_r;
reg [1:0]         s3_opcode_r;
reg [IDWIDTH-1:0] s4_a_r;
reg [IDWIDTH-1:0] s4_b_r;
reg [1:0]         s4_opcode_r;
reg [IDWIDTH-1:0] s5_a_r;
reg [IDWIDTH-1:0] s5_b_r;
reg [1:0]         s5_opcode_r;

always @(posedge clk) begin
	s2_a_r      <= A;
	s2_b_r      <= B;
	s2_opcode_r <= opcode;	
	s3_a_r      <= s2_a_r;
	s3_b_r      <= s2_b_r;	
	s3_opcode_r <= s2_opcode_r;
	s4_a_r      <= s3_a_r;	
	s4_b_r      <= s3_b_r;	
	s4_opcode_r <= s3_opcode_r;
	s5_a_r      <= s4_a_r;	
	s5_b_r      <= s4_b_r;	
	s5_opcode_r <= s4_opcode_r;
end

wire signed [DWIDTH:0] s5_a_s = s5_a_r[DWIDTH-1:0];
wire signed [DWIDTH:0] s5_b_s = s5_b_r[DWIDTH-1:0];
wire signed [IDWIDTH-2:0] s5_signedmul = s5_a_s * s5_b_s;

always @* begin
	case(s5_opcode_r) 
	2'b00: Y = {IWIDTH{1'bx}};
	2'b01: begin
		Y[IDWIDTH-2:0] = s5_signedmul;
		Y[IDWIDTH-1] = s5_signedmul[IDWIDTH-2];
	end
	2'b10: Y = {IWIDTH{1'bx}};
	2'b11: Y = {s5_a_r[IDWIDTH-1],s5_a_r} + {s5_b_r[IDWIDTH-1],s5_b_r};
	endcase
end

endmodule /* IALU_behav */