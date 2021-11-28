// Implementation of the FIR Control Logic & Wrapper
// For the W4823 FIR Project
// Anhang Li - Nov. 19 2021

module W4823_FIR(
	input           rst_n,		//
	input           clk1,		// Slow Clock 
	input           clk2,		// Fast Clock
	input [15:0]    din,		// FP16 Input Data
	input           valid_in,	// Input Ready
	input [16:0]    cin,		// Coefficient Input
	input [5:0]     caddr,		// Coefficient Address (64)
	input           cload,
	output [15:0]   dout,		// FP16 Output Data
	output          valid		// Output Ready
);

`define DEBUGINFO

// +----------------------------------+
// |     Part 1. State Controller     |
// +----------------------------------+

wire clk_fast   = clk2;
wire clk_fast_n = ~clk_fast;
reg [5:0] ss_r;		// Control State Register
reg [7:0] cycle_cnt_r;
wire cycle_load      = ss_r[0];
wire cycle_mul       = ss_r[1];
wire cycle_acc_thru  = ss_r[2];
wire cycle_acc       = ss_r[3];
wire cycle_accnorm   = ss_r[4];
wire cycle_sleep     = ss_r[5];
always @(posedge clk_fast or negedge rst_n) begin
	if(~rst_n) begin
		ss_r        <= 1;
		cycle_cnt_r <= 0;
	end else begin
		case(ss_r)
		6'b000001: begin					// DMEM WR
			ss_r <= 6'b000010;
		end
		6'b000010: begin
			if(cycle_cnt_r==8'd62) begin	// Constant MUL16i
				ss_r        <= 6'b000100;
				cycle_cnt_r <= 0;	
			end else begin
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
			end
		end
		6'b000100: begin
			if(cycle_cnt_r==8'd5) begin		// Accumulation ADD29i Thru
				ss_r        <= 6'b001000;
				cycle_cnt_r <= 0;
			end else begin
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
			end
		end
		6'b001000: begin
			if(cycle_cnt_r==8'd63) begin	// Accumulation ADD29i
				ss_r        <= 6'b010000;
				cycle_cnt_r <= 0;	
			end else begin
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
			end
		end
		6'b010000: begin					// Accumulation Normalize
			ss_r <= 6'b100000;
		end
		6'b100000: begin					// Sleep
			if(cycle_cnt_r==8'd122) begin
				ss_r        <= 6'b000001;
				cycle_cnt_r <= 0;	
			end else begin
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
			end
		end
		endcase
	end
end

// +------------------------------------+
// |     Part 2. Input Data Control     |
// +------------------------------------+
// 
reg cycle_load_dly_r;	
wire dmem_wr = cycle_load_dly_r; // Enable Writing 1/2 Cycle prior
always @(negedge clk_fast) begin
	if(cycle_load) cycle_load_dly_r <= 1;
	else           cycle_load_dly_r <= 0;
end
wire din_latch = cycle_load &~cycle_load_dly_r;
wire dmem_clk  = (cycle_load|cycle_mul)&clk_fast;	// DMEM Clock
// DMEM Clock has 1 extra clap prior to ALU Clock, to make it point to the next location of WR operation

wire alu_clk = (cycle_load_dly_r|cycle_mul|cycle_acc_thru|cycle_acc|cycle_accnorm) & clk_fast;

wire regf_wr;
wire regf_clk;
reg [5:0]	dmem_addr_r;

// Truncated, loops back automatically when dmem_addr_r >= 64;
always @(negedge dmem_clk or negedge rst_n) begin
	if(~rst_n) dmem_addr_r <= 0;
	else       dmem_addr_r <= dmem_addr_r + 1;
end


// +------------------------------+
// |     Part 3. ALU Data MUX     |
// +------------------------------+
// 

wire [17:0] cbuf_q_fp16;	// 10bit mantissa...?
wire [16:0] dmem_q_fp16;	// 10bit mantissa, ALU internally prefixed by 1'b1
wire [17:0] cmem_q_fp16i;	// 11bit mantissa...?
wire [29:0] regf_q_fp29i;

// Mapping Din (FP16) to FPALU input
wire [29:0] alumux_cbuf_fp16;
wire [29:0] alumux_dmem_fp16;
wire [29:0] alumux_cmem_fp16i;
wire [29:0] alumux_self_fp29i; 
wire [29:0] alumux_regf_fp29i;
wire [29:0] alumux_acc_fp29i;

reg [29:0]  alu_acc_29i_r;
reg [1:0]   alu_opcode;
reg [5:0]   cmem_addr_r;
reg [5:0]   regf_addr_r;

// ALU instance connections
wire        alu_a_s = alu_a_29i[29];		//  1b
wire [6:0]  alu_a_e = alu_a_29i[28:22];		//	7b
wire [21:0] alu_a_m = alu_a_29i[21:0];		//  22b
wire        alu_b_s = alu_b_29i[29];		//  1b
wire [6:0]  alu_b_e = alu_b_29i[28:22];		//	7b
wire [21:0] alu_b_m = alu_b_29i[21:0];		//  22b
reg [29:0]  alu_a_29i;
reg [29:0]  alu_b_29i;
wire        alu_y_s;						//  1b
wire [6:0]	alu_y_e;
wire [21:0]	alu_y_m;
wire [29:0] alu_y_29i = {alu_y_s, alu_y_e, alu_y_m};

// ALL FP16 Data Connectors are RIGHT ALIGNED
// MUX of input A
assign alumux_cbuf_fp16  = {cbuf_q_fp16[16], 1'bx, cbuf_q_fp16[15:10], {12{1'bx}}, cbuf_q_fp16[9:0]}; 		// FP16
assign alumux_dmem_fp16  = {dmem_q_fp16[16], 1'bx, dmem_q_fp16[15:10], {12{1'bx}}, dmem_q_fp16[9:0]}; 		// FP16
assign alumux_acc_fp29i  = alu_acc_29i_r;	// from accumulator, FP29i

// MUX of input B
assign alumux_cmem_fp16i = {cmem_q_fp16i[17], 1'bx, cmem_q_fp16i[16:11], {11{1'bx}}, cmem_q_fp16i[10:0]};	// FP16i
assign alumux_regf_fp29i = regf_q_fp29i;	// FP29i
assign alumux_self_fp29i = alu_y_29i;		// from the output,  FP29i

always @* begin
	alu_opcode = 2'bxx;									// Default (doing nothing, can be any value)
	if(cycle_load) begin					// MUL16i First Cycle
		alu_a_29i = alumux_cbuf_fp16;
		alu_b_29i = alumux_cmem_fp16i;
		alu_opcode = 2'b10;
	end
	
	if(cycle_mul) begin						// MUL16i Subseq. Cycles (63x)
		alu_a_29i = alumux_dmem_fp16;
		alu_a_29i = alumux_cmem_fp16i;
		alu_opcode = 2'b10;
	end         

	if(cycle_acc_thru) begin				// ADD29i First 5 Cycles Feed-Thru
		alu_a_29i = alumux_self_fp29i;
		alu_b_29i = alumux_acc_fp29i;
		alu_opcode = 2'b11;
	end 

	if(cycle_acc) begin						// ADD29i Subseq. Cycles
		alu_a_29i = alumux_regf_fp29i;
		alu_b_29i = alumux_acc_fp29i;
		alu_opcode = 2'b11;
	end 

	if(cycle_accnorm) begin					// ADD29NORM Final Cycle
		alu_a_29i = alumux_regf_fp29i;		// Last ACC input
		alu_b_29i = alumux_acc_fp29i;
		alu_opcode = 2'b00;		
	end
end


`ifdef DEBUGINFO
integer alu_clk_cnt;
always @(posedge alu_clk or posedge cycle_load) begin
	if(cycle_load) alu_clk_cnt = 0;
	else           alu_clk_cnt = alu_clk_cnt + 1;
end 

`endif /* DEBUGINFO */

endmodule /* W4823_FIR */

/* vim: set ts=4 sw=4 noet */