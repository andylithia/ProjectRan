// Implementation of the FIR Control Logic & Wrapper
// For the W4823 FIR Project
// Anhang Li - Nov. 27 2021

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
//
wire       clk_fast   = clk2;
wire       clk_fast_n = ~clk_fast;
reg [15:0] ss_r;		// Control State Register
reg [7:0]  cycle_cnt_r;
reg        first_cycle_r;

// Note: cycle_* dictates the current state at the INPUT OF ALU
wire cycle_load      = ss_r[0]; // 1
wire cycle_mul_ndav  = ss_r[1]; // 3
wire cycle_mul       = ss_r[2];	// 60
wire cycle_acc_thru  = ss_r[3];	// 5
wire cycle_acc       = ss_r[4];	// 65
wire cycle_acc_p1    = ss_r[5]; // 2, Delay a for 1 Cycle
wire cycle_acc_cwr   = ss_r[6]; // 1
wire cycle_acc_dwr   = ss_r[7];	// 1
wire cycle_acc_ewr	 = ss_r[8];	// 1
wire cycle_acc_p21   = ss_r[9]; // 2, 
wire cycle_acc_p22   = ss_r[10]; // 4
wire cycle_acc_p31   = ss_r[11]; // 1
wire cycle_acc_p32   = ss_r[12]; // 4
wire cycle_accnorm   = ss_r[13]; // 5
wire cycle_sleep     = ss_r[14]; // 100
wire cycle_dinlatch  = ss_r[15]; // 1
// The following coding is to ensure glitch-free clock gating
// To get ALU input mux, xor the nearby two states
always @(posedge clk_fast or negedge rst_n) begin
	if(~rst_n) begin
		// Sleep Away the First Cycle
		ss_r          <= 16'b0110_0000_0000_0000;
		cycle_cnt_r   <= 8'd105;
		first_cycle_r <= 1'b1;
	end else begin
		case(ss_r)
		16'b1000_0000_0000_0001:			// DMEM WR & MUL16i First Cycle
			ss_r <= 16'b0000_0000_0000_0011;
		16'b0000_0000_0000_0011: begin	// MUL16i First 4 Cycles
			if(cycle_cnt_r==8'd2) begin	
				ss_r        <= 16'b0000_0000_0000_0110;
				cycle_cnt_r <= 0;	
			end else
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b0000_0000_0000_0110: begin	// Constant MUL16i
			if(cycle_cnt_r==8'd59) begin
				ss_r        <= 16'b0000_0000_0000_1100;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b0000_0000_0000_1100: begin	// Acc Write Thru
			if(cycle_cnt_r==8'd4) begin
				ss_r        <= 16'b0000_0000_0001_1000;
				cycle_cnt_r <= 0;
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b0000_0000_0001_1000: begin	// Penta ACC
			if(cycle_cnt_r==8'd59) begin
				ss_r        <= 16'b0000_0000_0011_0000;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b0000_0000_0011_0000: begin	// Acc, A+B
			if(cycle_cnt_r==8'd1) begin	// Accumulation ADD29i
				ss_r        <= 16'b0000_0000_0110_0000;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b0000_0000_0110_0000:		// Acc, CWR, A+B in S2
				ss_r        <= 16'b0000_0000_1100_0000;
		16'b0000_0000_1100_0000: 	// Acc, DWR, A+B in S3
				ss_r        <= 16'b0000_0001_1000_0000;
		16'b0000_0001_1000_0000:	// Acc, EWR, A+B in S4
				ss_r        <= 16'b0000_0011_0000_0000;
		16'b0000_0011_0000_0000: begin	// Acc, P21, A+B in S5, Recall C
			if(cycle_cnt_r==8'd1) begin	// Accumulation ADD29i
				ss_r        <= 16'b0000_0110_0000_0000;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b0000_0110_0000_0000: begin	// Acc, P22, Calculate A+B+C
			if(cycle_cnt_r==8'd3) begin	// Accumulation ADD29i
				ss_r        <= 16'b0000_1100_0000_0000;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b0000_1100_0000_0000: begin	// Acc, P31, A+B+C Ready, Recall D
			if(cycle_cnt_r==8'd1) begin	// Accumulation ADD29i
				ss_r        <= 16'b0001_1000_0000_0000;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b0001_1000_0000_0000: begin	// Acc, P32, Calculate A+B+C+D
			if(cycle_cnt_r==8'd3) begin	// Accumulation ADD29i
				ss_r        <= 16'b0011_0000_0000_0000;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b0011_0000_0000_0000: begin	// Acc Normalize, A+B+C+D+E, 5 Cycles
			if(cycle_cnt_r==8'd4) begin
				ss_r        <= 16'b0110_0000_0000_0000;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b0110_0000_0000_0000: begin					// Sleep
			if(cycle_cnt_r==8'd104) begin
				ss_r          <= 16'b1100_0000_0000_0000;
				cycle_cnt_r   <= 0;	
				first_cycle_r <= 0;
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		16'b1100_0000_0000_0000:			// Din Latch Cycle
			ss_r <= 16'b1000_0000_0000_0001;
		endcase
	end
end

// +------------------------------------+
// |     Part 2. Input Data Control     |
// +------------------------------------+
// 
// !!! All memory addresses are synced to negedge !!!
//
reg cycle_load_dly_r;	
always @(negedge clk_fast) begin
	if(cycle_load) cycle_load_dly_r <= 1;
	else           cycle_load_dly_r <= 0;
end

// CMEM can be written-to in the first 256-clk cycle
// from the outside
wire        cmem_wr = first_cycle_r;	// Internal
wire        cmem_clk;					// Muxed
wire [5:0]  cmem_addr;					// Muxed
reg  [5:0]  cmem_addr_r;				// Internal
wire [16:0] cmem_din_FP16i = cin;		// External 

reg         dmem_wr_r;
reg [5:0]	dmem_addr_r;
assign cmem_addr = (first_cycle_r) ? caddr : cmem_addr_r;
assign cmem_clk  = (first_cycle_r) ? cload : dmem_clk;
always @(posedge cycle_dinlatch or negedge dmem_clk) begin
	if(cycle_dinlatch&~cycle_load) begin
		dmem_wr_r   <= 1;
		cmem_addr_r <= 0;
	end else begin
		dmem_wr_r   <= 0;
		cmem_addr_r <= cmem_addr_r + 1;
	end
end

wire alu_clk = ~cycle_sleep & clk_fast;
// To remove clock hazard in DMEM clock gating
// Without this, the last cycle may end 1/2 clock period earlier
reg cycle_mul_dly1_r;
always @(posedge alu_clk) begin
	if(cycle_mul)        cycle_mul_dly1_r = 1;
	else                 cycle_mul_dly1_r = 0;
end

reg cycle_acc_thru_dly1_r;
always @(negedge alu_clk) begin
	if(cycle_acc_thru) cycle_acc_thru_dly1_r = 1;
	else               cycle_acc_thru_dly1_r = 0;
end

// DMEM Clock has 1 extra clap prior to ALU Clock, to make it point to the next location of WR operation
wire din_latch = cycle_load &~cycle_load_dly_r; // Circluar Buffer Input Clock
wire dmem_clk  = (cycle_load|cycle_mul_ndav|cycle_mul) &~cycle_acc_thru_dly1_r & clk_fast;	// DMEM Clock

// Truncated, loops back automatically when dmem_addr_r >= 64;
always @(negedge dmem_clk or negedge rst_n) begin
	if(~rst_n) dmem_addr_r <= 0;
	else       dmem_addr_r <= dmem_addr_r + 1;
end

// +--------------------------------------+
// |     Part 3. REGFile Data Control     |
// +--------------------------------------+
// 
reg  regf_wr_r;
wire regf_clken = (regf_wr_r|cycle_acc_thru);
wire regf_clk   = regf_clken & alu_clk;
reg [5:0]    regf_addr_r;

always @(negedge alu_clk) begin
	if(cycle_mul&~cycle_acc_thru) regf_wr_r = 1;
	else                          regf_wr_r = 0;

	if(~regf_clken) regf_addr_r <= 0;
	else            regf_addr_r <= regf_addr_r + 1;
end

// +------------------------------+
// |     Part 3. ALU Data MUX     |
// +------------------------------+
// 
wire [17:0] cbuf_q_fp16;	// 10bit mantissa, ALU internally prefixed by 1'b1
wire [16:0] dmem_q_fp16;	// 10bit mantissa, ALU internally prefixed by 1'b1
wire [16:0] cmem_q_fp16i;	// 11bit mantissa, raw, denormalized data
wire [29:0] regf_q_fp29i;	// 

// Mapping Din (FP16) to FPALU input
wire [29:0] alumux_cbuf_fp16;
wire [29:0] alumux_dmem_fp16;
wire [29:0] alumux_cmem_fp16i;
wire [29:0] alumux_self_fp29i; 
wire [29:0] alumux_regf_fp29i;
wire [29:0] alumux_acc_fp29i;

reg [1:0]   alu_opcode;

// ALU instance connections
reg [29:0]  alu_a_29i_r;
reg [29:0]  alu_b_29i_r;
reg [29:0]  alu_a_29i;
reg [29:0]  alu_b_29i;
wire        alu_a_s = alu_a_29i_r[29];		//  1b
wire [6:0]  alu_a_e = alu_a_29i_r[28:22];	//	7b
wire [21:0] alu_a_m = alu_a_29i_r[21:0];	//  22b
wire        alu_b_s = alu_b_29i_r[29];		//  1b
wire [6:0]  alu_b_e = alu_b_29i_r[28:22];	//	7b
wire [21:0] alu_b_m = alu_b_29i_r[21:0];	//  22b
wire        alu_y_s;
wire [6:0]	alu_y_e;
wire [21:0]	alu_y_m;
wire [29:0] alu_y_29i = {alu_y_s, alu_y_e, alu_y_m};

reg [29:0] alumux_regac_fp29i_r;
reg [29:0] alumux_regd_fp29i_r;
reg [29:0] alumux_rege_fp29i_r;

wire alumux_regac_latch = (cycle_acc_p1&~cycle_acc_cwr)&alu_clk|cycle_acc_dwr;

// S1 doesn't have a latch
always @(posedge alu_clk) begin
	alu_a_29i_r <= alu_a_29i;
	alu_b_29i_r <= alu_b_29i;
end

// Saving C,D,E for future cycles
always @(posedge alumux_regac_latch) 
	alumux_regac_fp29i_r <= alumux_self_fp29i;
always @(posedge cycle_acc_ewr) 
	alumux_regd_fp29i_r <= alumux_self_fp29i;
always @(posedge cycle_acc_p21) 
	alumux_rege_fp29i_r <= alumux_self_fp29i;

// ALL FP16 Data Connectors are RIGHT ALIGNED
// MUX of input A
assign alumux_cbuf_fp16  = {cbuf_q_fp16[16], 1'bx, cbuf_q_fp16[15:10], {12{1'bx}}, cbuf_q_fp16[9:0]}; 		// FP16
assign alumux_dmem_fp16  = {dmem_q_fp16[16], 1'bx, dmem_q_fp16[15:10], {12{1'bx}}, dmem_q_fp16[9:0]}; 		// FP16

// MUX of input B
assign alumux_cmem_fp16i = {cmem_q_fp16i[16], 1'bx, cmem_q_fp16i[15:11], {11{1'bx}}, cmem_q_fp16i[10:0]};	// FP16i
assign alumux_regf_fp29i = regf_q_fp29i;	// FP29i
assign alumux_self_fp29i = alu_y_29i;		// from the output,  FP29i
`ifdef DEBUGINFO
integer dbg_alumux_state;
`endif /* DEBUGINFO */
always @* begin
	alu_opcode = 2'bxx;		// Default (doing nothing, can be any value)
	// Note: all conditions are if... if... rather than if... else if...
	//       because these conditions are mutally exclusive
	if(cycle_dinlatch&cycle_load) begin					// MUL16i First Cycle
		alu_a_29i = alumux_cbuf_fp16;
		alu_b_29i = alumux_cmem_fp16i;
		alu_opcode = 2'b10;
		`ifdef DEBUGINFO
			dbg_alumux_state = 0;
		`endif /* DEBUGINFO */
	end

	if(cycle_mul_ndav) begin
		alu_a_29i = alumux_dmem_fp16;
		alu_a_29i = alumux_cmem_fp16i;
		alu_opcode = 2'b10;
		`ifdef DEBUGINFO
			dbg_alumux_state = 1;
		`endif /* DEBUGINFO */
	end         
	
	// ADD29i First 5 Cycles Feed-Thru
	if(cycle_acc_thru&~cycle_acc) begin		
		alu_a_29i = alumux_self_fp29i;	
		alu_b_29i = 30'b0;
		alu_opcode = 2'b11;
		`ifdef DEBUGINFO
			dbg_alumux_state = 2;
		`endif /* DEBUGINFO */
	end 

	// Penta Summation
	if(cycle_acc&~cycle_acc_p1) begin
		alu_a_29i = alumux_self_fp29i;
		alu_b_29i = alumux_regf_fp29i;
		alu_opcode = 2'b11;
		`ifdef DEBUGINFO
			dbg_alumux_state = 3;
		`endif /* DEBUGINFO */
	end 

	// A+B, the first cycle is discarded
	if(cycle_acc_p1 & ~cycle_acc_cwr) begin
		alu_a_29i = alumux_self_fp29i;
		alu_b_29i = alumux_regac_fp29i_r;
		alu_opcode = 2'b11;
		`ifdef DEBUGINFO
			dbg_alumux_state = 4;
		`endif /* DEBUGINFO */
	end

	// Wait for A+B
	if((cycle_acc_cwr|cycle_acc_dwr|cycle_acc_ewr)&~cycle_acc_p21) begin
		alu_a_29i = {30{1'bx}};
		alu_b_29i = {30{1'bx}};
		alu_opcode = 2'bxx;
		`ifdef DEBUGINFO
			dbg_alumux_state = 5;
		`endif /* DEBUGINFO */
	end

	// Start A+B+C
	if(cycle_acc_p21&~cycle_acc_p22) begin
		alu_a_29i = alumux_self_fp29i;
		alu_b_29i = alumux_regac_fp29i_r;
		alu_opcode = 2'b11;
		`ifdef DEBUGINFO
			dbg_alumux_state = 6;
		`endif /* DEBUGINFO */
	end

	// Wait for A+B+C
	if(cycle_acc_p22&~cycle_acc_p31) begin
		alu_a_29i = {30{1'bx}};
		alu_b_29i = {30{1'bx}};
		alu_opcode = 2'bxx;
		`ifdef DEBUGINFO
			dbg_alumux_state = 7;
		`endif /* DEBUGINFO */
	end
	
	// Start A+B+C+D
	if(cycle_acc_p31&~cycle_acc_p32) begin
		alu_a_29i = alumux_self_fp29i;
		alu_b_29i = alumux_regd_fp29i_r;
		alu_opcode = 2'b11;
		`ifdef DEBUGINFO
			dbg_alumux_state = 8;
		`endif /* DEBUGINFO */
	end

	// Wait for A+B+C+D
	if(cycle_acc_p32&~cycle_accnorm) begin
		alu_a_29i = {30{1'bx}};
		alu_b_29i = {30{1'bx}};
		alu_opcode = 2'bxx;
		`ifdef DEBUGINFO
			dbg_alumux_state = 9;
		`endif /* DEBUGINFO */
	end

	// Start A+B+C+D+E
	if(cycle_accnorm&~cycle_sleep) begin	// ADD29NORM Final Cycle
		alu_a_29i = alumux_self_fp29i;		// Last ACC input
		alu_b_29i = alumux_rege_fp29i_r;
		alu_opcode = 2'b00;		// ADD29i with Normalization	
		`ifdef DEBUGINFO
			dbg_alumux_state = 10;
		`endif /* DEBUGINFO */
	end
end

// ALU instance
/*
FPALU u_fpalu(
	.clk               (alu_clk   ),
	.opcode            (alu_opcode),
	.din_uni_a_sgn     (alu_a_s   ),
	.din_uni_a_exp     (alu_a_e   ),
	.din_uni_a_man_dn  (alu_a_m   ),
	.din_uni_b_sgn     (alu_b_s   ),
	.din_uni_b_exp     (alu_b_e   ),
	.din_uni_b_man_dn  (alu_b_m   ),
	.dout_uni_y_sgn    (alu_y_s   ),
	.dout_uni_y_exp    (alu_y_e   ),
	.dout_uni_y_man_dn (alu_y_m   )
);
*/

// +--------------------------+
// |     Part 4. Memories     |
// +--------------------------+
// 
`ifdef USE_VENDOR_MEMORY

`else

// CMEM: 17b x 64w
sp_sram #(
	.ADDR_WIDTH(6),
	.DATA_WIDTH(17)
) u_cmem (
	.clk  (cmem_clk      ),
	.addr (cmem_addr     ),
	.din  (cmem_din_FP16i),
	.wr   (cmem_wr       ),
	.qout (cmem_q_fp16i  )
);


`endif /* USE_VENDOR_MEMORY */



`ifdef DEBUGINFO
integer dbg_alu_clk_cnt;
reg     dbg_alu_outrdy;
always @(posedge alu_clk or posedge cycle_dinlatch) begin
	if(cycle_dinlatch) dbg_alu_clk_cnt <= 0;
	else           dbg_alu_clk_cnt <= dbg_alu_clk_cnt + 1;
	
	if(cycle_dinlatch)              dbg_alu_outrdy <= 0;
	else begin
		if(dbg_alu_clk_cnt==3)  dbg_alu_outrdy <= 1;
	end
end 

`endif /* DEBUGINFO */

endmodule /* W4823_FIR */

/* vim: set ts=4 sw=4 noet */