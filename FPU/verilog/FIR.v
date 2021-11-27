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

reg [1:0] alu_opcode;
always @* begin
	alu_opcode = 2'bxx;									// Default (doing nothing, can be any value)
	if(cycle_mul) alu_opcode = 2'b10;	                // MUL16i
	if(cycle_acc|cycle_acc_thru) alu_opcode = 2'b11;	// ADD29i
	if(cycle_accnorm) alu_opcode = 2'b00;				// ADD29NORM
end

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


// +-----------------------------------+
// |     Part 3. REGF Data Control     |
// +-----------------------------------+
// 




wire [5:0]	regf_addr;
wire        regf_bypass;

`ifdef DEBUGINFO
integer alu_clk_cnt;
always @(posedge alu_clk or posedge cycle_load) begin
	if(cycle_load) alu_clk_cnt = 0;
	else           alu_clk_cnt = alu_clk_cnt + 1;
end 

`endif /* DEBUGINFO */

endmodule /* W4823_FIR */

/* vim: set ts=4 sw=4 noet */