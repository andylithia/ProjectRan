// Implementation of the FIR Control Logic & Wrapper
// For the W4823 FIR Project
// Anhang Li - Nov. 27 2021

`timescale 1ns/1fs
module W4823_IFIR(
	input           rst_n,		//
	input           clk_slow,	// Slow Clock (Unused, Internally Generated) 
	input           clk,		// Fast Clock
	input [15:0]    din,		// FP16 Input Data
	input           valid_in,	// Input Ready
	input [16:0]    cin,		// Coefficient Input
	input [5:0]     caddr,		// Coefficient Address (64)
	input           cload,
	output [15:0]   dout,		// FP16 Output Data
	output          valid,		// Output Ready
	output [28:0]   dout_29i	// Raw Output from the ALU
);

// Remember to disable this before DC
// `define DEBUGINFO
// `define USE_VENDOR_CGC
`define USE_VENDOR_MEMORY
`define USE_DUMMY_ALU
// +----------------------------------+
// |     Part 1. State Controller     |
// +----------------------------------+
//
wire       clk_fast   = clk;
wire       clk_fast_n = ~clk_fast;
reg [7:0]  ss_r;		// Control State Register
reg [7:0]  cycle_cnt_r;
reg        first_cycle_r;


localparam SLEEP_LEN = 106;

// Note: cycle_* dictates the current state at the INPUT OF ALU
//                           76543210
`define S0_LOAD      8'b00000001
`define S1_MUL_NDAV  8'b00000011
`define S2_MUL       8'b00000010
`define S3_ACC_THRU  8'b00000110
`define S4_ACC       8'b00000100
`define S5_ACC_P1    8'b00001100
`define S6_ACC_CWR   8'b00001000
`define S7_ACC_DWR   8'b00011000
`define S8_ACC_EWR   8'b00010000
`define S9_ACC_P21   8'b00110000
`define SA_ACC_P22   8'b00100000
`define SB_ACC_P31   8'b01100000
`define SC_ACC_P32   8'b01000000
`define SD_ACC_NORM  8'b11000000
`define SE_SLEEP     8'b10000000
`define SF_DINLATCH  8'b10000001

wire cycle_load      = ss_r[0]&~ss_r[7]; // 1
wire cycle_mul_ndav  = ss_r[0]& ss_r[1]; // 4
wire cycle_mul       = ss_r[1]&~ss_r[0]; // 60
wire cycle_acc_thru  = ss_r[1]& ss_r[2]; // 5
wire cycle_acc       = ss_r[2]&~ss_r[1]; // 65
wire cycle_acc_p1    = ss_r[2]& ss_r[1]; // 2, Delay a for 1 Cycle
wire cycle_acc_cwr   = ss_r[3]&~ss_r[2]; // 1
wire cycle_acc_dwr   = ss_r[3]& ss_r[2]; // 1
wire cycle_acc_ewr	 = ss_r[4]&~ss_r[3]; // 1
wire cycle_acc_p21   = ss_r[4]& ss_r[3]; // 2, 
wire cycle_acc_p22   = ss_r[5]&~ss_r[4]; // 4
wire cycle_acc_p31   = ss_r[5]& ss_r[4]; // 1
wire cycle_acc_p32   = ss_r[6]&~ss_r[5]; // 4
wire cycle_accnorm   = ss_r[6]& ss_r[5]; // 5
wire cycle_sleep     = ss_r[7]&~ss_r[6]; // 100
wire cycle_dinlatch  = ss_r[7]& ss_r[0]; // 1
// The following coding is to ensure glitch-free clock gating
// To get ALU input mux, xor the nearby two states
always @(posedge clk_fast or negedge rst_n) begin
	if(~rst_n) begin
		// Sleep Away the First Cycle
		ss_r          <= `SE_SLEEP;
		cycle_cnt_r   <= SLEEP_LEN;
		first_cycle_r <= 1'b1;
	end else begin
		case(ss_r)
		`S0_LOAD:			// DMEM WR & MUL16i First Cycle
			ss_r <= `S1_MUL_NDAV;
		`S1_MUL_NDAV: begin	// MUL16i First 4 Cycles
			if(cycle_cnt_r==8'd3) begin	
				ss_r        <= `S2_MUL;
				cycle_cnt_r <= 0;	
			end else
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		`S2_MUL: begin	// Constant MUL16i
			if(cycle_cnt_r==8'd57) begin
				ss_r        <= `S3_ACC_THRU;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		`S3_ACC_THRU: begin	// Acc Write Thru
			if(cycle_cnt_r==8'd4) begin
				ss_r        <= `S4_ACC;
				cycle_cnt_r <= 0;
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		`S4_ACC: begin	// Penta ACC
			if(cycle_cnt_r==8'd58) begin
				ss_r        <= `S5_ACC_P1;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		`S5_ACC_P1: begin	// Acc, A+B
			if(cycle_cnt_r==8'd1) begin	// Accumulation ADD29i
				ss_r        <= `S6_ACC_CWR;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		`S6_ACC_CWR: begin	// Acc, CWR, A+B in S2
			if(cycle_cnt_r==8'd1) begin
				ss_r        <= `S7_ACC_DWR;
				cycle_cnt_r <= 0;
			end else
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
	end
		`S7_ACC_DWR: ss_r   <= `S8_ACC_EWR;	// Acc, DWR, A+B in S3
		`S8_ACC_EWR: ss_r   <= `S9_ACC_P21; // Acc, EWR, A+B in S4
		`S9_ACC_P21: begin	// Acc, P21, A+B in S5, Recall C
			if(cycle_cnt_r==8'd1) begin	// Accumulation ADD29i
				ss_r        <= `SA_ACC_P22;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		`SA_ACC_P22: begin	// Acc, P22, Calculate A+B+C
			if(cycle_cnt_r==8'd3) begin	// Accumulation ADD29i
				ss_r        <= `SB_ACC_P31;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		`SB_ACC_P31: ss_r   <= `SC_ACC_P32; // Acc, P31, A+B+C Ready, Recall D
		`SC_ACC_P32: begin	// Acc, P32, Calculate A+B+C+D
			if(cycle_cnt_r==8'd3) begin	// Accumulation ADD29i
				ss_r        <= `SD_ACC_NORM;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		`SD_ACC_NORM: begin	// Acc Normalize, A+B+C+D+E, 5 Cycles
			if(cycle_cnt_r==8'd4) begin
				ss_r        <= `SE_SLEEP;
				cycle_cnt_r <= 0;	
			end else 
				cycle_cnt_r <= cycle_cnt_r + 1'b1;
		end
		`SE_SLEEP: begin					// Sleep
			if(cycle_cnt_r==SLEEP_LEN-1) begin
				ss_r          <= `SF_DINLATCH;
				cycle_cnt_r   <= 0;	
				first_cycle_r <= 0;
			end else 
				cycle_cnt_r   <= cycle_cnt_r + 1'b1;
		end
		`SF_DINLATCH: ss_r    <= `S0_LOAD; // Din Latch Cycle
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
wire        cmem_wr = first_cycle_r&clk_slow;	// Internal
wire        cmem_clk;					// Muxed
wire [5:0]  cmem_addr;					// Muxed
reg  [5:0]  cmem_addr_r;				// Internal
wire [16:0] cmem_din_FP16i = cin;		// External 

reg         dmem_wr_r;
wire         dmem_clk;
wire         dmem_clk_en;
// wire         dmem_wr_r = cycle_dinlatch&~cycle_load;
reg [5:0]	 dmem_addr_r;
// DMEM Clock has 1 extra clap prior to ALU Clock, to make it point to the next location of WR operation
// wire din_latch = cycle_load &~cycle_load_dly_r; // Circluar Buffer Input Clock
wire din_latch;
reg [15:0] din_r;

assign cmem_addr = (first_cycle_r) ? caddr : cmem_addr_r;
// assign cmem_clk  = (first_cycle_r) ? cload : dmem_clk;
wire dmem_cmem_rst = dmem_wr_r&~dmem_clk;
reg cycle_dinlatch_pulse_r;
// Modded because DC complains about polarity
always @(posedge cycle_dinlatch or negedge clk_fast) begin
	if(~clk_fast) cycle_dinlatch_pulse_r <= 0;
	else          cycle_dinlatch_pulse_r <= 1;
end
/*
always @(negedge cycle_dinlatch_pulse_r) begin
	din_r <= din;
end
*/
always @(posedge cycle_dinlatch) begin
	din_r <= din;
end
always @(posedge cycle_dinlatch_pulse_r or negedge dmem_clk) begin
	if(cycle_dinlatch_pulse_r) begin
		// dmem_wr_r   <= 1;
		cmem_addr_r <= 0;
	end else begin
		// dmem_wr_r   <= 0;
		cmem_addr_r <= cmem_addr_r + 1;
	end
end

always @(negedge clk_fast) begin
	if(cycle_dinlatch&&dmem_wr_r==0) dmem_wr_r <= 1;
	else                             dmem_wr_r <= 0;
end

wire alu_clk_en = ~cycle_sleep;
wire alu_clk;
// wire alu_clk    =  clk_fast;
// To remove clock hazard in DMEM clock gating
// Without this, the last cycle may end 1/2 clock period earlier
reg cycle_mul_dly1_r;
always @(posedge alu_clk) begin
	if(cycle_mul)        cycle_mul_dly1_r <= 1;
	else                 cycle_mul_dly1_r <= 0;
end

reg cycle_acc_thru_dly1_r;
always @(negedge alu_clk) begin
	if(cycle_acc_thru) cycle_acc_thru_dly1_r <= 1;
	else               cycle_acc_thru_dly1_r <= 0;
end

reg cycle_acc_thru_dly2_r;
always @(posedge alu_clk) begin
	if(cycle_acc_thru) cycle_acc_thru_dly2_r <= 1;
	else               cycle_acc_thru_dly2_r <= 0;
end

assign din_latch = cycle_dinlatch_pulse_r;
assign dmem_clk_en = (cycle_dinlatch|cycle_load|cycle_mul_ndav|cycle_mul) & ~cycle_acc_thru_dly1_r;
// Truncated, loops back automatically when dmem_addr_r >= 64;

always @(negedge clk_fast or negedge rst_n) begin
	if(~rst_n)	dmem_addr_r <= 0;
	else if(dmem_clk_en) dmem_addr_r <= dmem_addr_r + 1;
end

// Clock Gating
//
`ifdef USE_VENDOR_CGC
		
`else
	icgc u_cgc_cmem(.CK(clk_fast),.E(first_cycle_r|dmem_clk_en),.ECK(cmem_clk));
	// icgc u_cgc_alu(.CK(clk_fast),.E(alu_clk_en), .ECK(alu_clk));
	assign alu_clk = clk_fast & alu_clk_en;
	assign dmem_clk  = dmem_clk_en & clk_fast;	// DMEM Clock

`endif /* USE_VENDOR_CGC */

// +--------------------------------------+
// |     Part 3. REGFile Data Control     |
// +--------------------------------------+
// 
reg  regf_wr_r;
wire regf_clken = (regf_wr_r|cycle_acc_thru);
wire regf_clk   = regf_clken & alu_clk;
reg [5:0]    regf_addr_r;

always @(negedge alu_clk) begin
	if(cycle_mul&~cycle_acc_thru_dly2_r) regf_wr_r = 1;
	else                          regf_wr_r = 0;

	if((~regf_clken)|(cycle_mul&cycle_acc_thru_dly2_r)) regf_addr_r <= 0;
	else            regf_addr_r <= regf_addr_r + 1;
end

// +------------------------------+
// |     Part 3. ALU Data MUX     |
// +------------------------------+
// 
wire [15:0] dmem_q_fp16;	// 10bit mantissa, ALU internally prefixed by 1'b1
wire [16:0] cmem_q_fp16i;	// 11bit mantissa, raw, denormalized data
wire [28:0] regf_q_fp29i;	// 

// Mapping Din (FP16) to FPALU input
wire [28:0] alumux_din_fp16;
wire [28:0] alumux_dmem_fp16;
wire [28:0] alumux_cmem_fp16i;
wire [28:0] alumux_self_fp29i; 
wire [28:0] alumux_regf_fp29i;
wire [28:0] alumux_acc_fp29i;

reg [1:0]   alu_opcode;

// ALU instance connections
reg [28:0]  alu_a_29i_r;
reg [28:0]  alu_b_29i_r;
reg [28:0]  alu_a_29i;
reg [28:0]  alu_b_29i;
wire        alu_a_s = alu_a_29i_r[28];		//  1b
wire [5:0]  alu_a_e = alu_a_29i_r[27:22];	//	6b
wire [21:0] alu_a_m = alu_a_29i_r[21:0];	//  22b
wire        alu_b_s = alu_b_29i_r[28];		//  1b
wire [5:0]  alu_b_e = alu_b_29i_r[27:22];	//	6b
wire [21:0] alu_b_m = alu_b_29i_r[21:0];	//  22b
wire        alu_y_s;
wire [5:0]	alu_y_e;
wire [21:0]	alu_y_m;
wire [28:0] alu_y_29i = {alu_y_s, alu_y_e, alu_y_m};

// Saving C,D,E for future cycles
reg [28:0] alumux_dly;
reg [28:0] alumux_dly1;
reg [28:0] alumux_dly2;
reg [28:0] alumux_dly3;
always @(negedge alu_clk) begin
	if(cycle_acc_p1|cycle_acc_dwr) begin
		alumux_dly <= alumux_self_fp29i;
		alumux_dly1 <= alumux_dly;
		alumux_dly2 <= alumux_dly1;
	end
	if(cycle_acc_p1) begin
		alumux_dly3 <= alumux_dly2;
	end
end

// S1 doesn't have a latch
reg [1:0] alu_opcode_r;
always @(posedge alu_clk) begin
	alu_a_29i_r  <= alu_a_29i;
	alu_b_29i_r  <= alu_b_29i;
	alu_opcode_r <= alu_opcode;
end



// ALL FP16 Data Connectors are RIGHT ALIGNED
// MUX of input A
assign alumux_din_fp16  = {din_r[15], 1'bx, din_r[14:10], {12{1'bx}}, din_r[9:0]}; 		// FP16
assign alumux_dmem_fp16  = {dmem_q_fp16[15], 1'bx, dmem_q_fp16[14:10], {12{1'bx}}, dmem_q_fp16[9:0]}; 		// FP16

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
	if(cycle_dinlatch) begin					// MUL16i First Cycle
		alu_a_29i = alumux_din_fp16;
		alu_b_29i = alumux_cmem_fp16i;
		alu_opcode = 2'b10;
		`ifdef DEBUGINFO
			dbg_alumux_state = 0;
		`endif /* DEBUGINFO */
	end

	if((cycle_mul_ndav|cycle_mul)&~cycle_acc_thru) begin
		alu_a_29i = alumux_dmem_fp16;
		alu_b_29i = alumux_cmem_fp16i;
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
		alu_b_29i = {29{1'b0}};//alumux_regac_fp29i_r;
		alu_opcode = 2'b11;
		`ifdef DEBUGINFO
			dbg_alumux_state = 4;
		`endif /* DEBUGINFO */
	end

	// Wait for A+B
	if((cycle_acc_cwr|cycle_acc_dwr|cycle_acc_ewr)&~cycle_acc_p21) begin
		alu_a_29i = alumux_dly;
		alu_b_29i = alu_a_29i_r;
		alu_opcode = 2'bxx;
		`ifdef DEBUGINFO
			dbg_alumux_state = 5;
		`endif /* DEBUGINFO */
	end

	// Start A+B+C
	if(cycle_acc_p21&~cycle_acc_p22) begin
		alu_a_29i = alumux_self_fp29i;
		alu_b_29i = alumux_dly1;
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
		alu_b_29i = alumux_dly2;
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
		alu_b_29i = alumux_dly3;
		alu_opcode = 2'b00;		// ADD29i with Normalization	
		`ifdef DEBUGINFO
			dbg_alumux_state = 10;
		`endif /* DEBUGINFO */
	end
end

// ALU instance
`ifdef USE_DUMMY_ALU
	FPALU_dummy u_fpalu(
		.clk               (alu_clk   ),
		.opcode            (alu_opcode_r),
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
`else
	FPALU u_fpalu(
		.clk               (alu_clk   ),
		.opcode            (alu_opcode_r),
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
`endif /* USE_DUMMY_ALU */
assign dout     = alu_y_29i;
assign dout_29i = alu_y_29i;

// +--------------------------+
// |     Part 4. Memories     |
// +--------------------------+
// 
`ifdef USE_VENDOR_MEMORY
	
	// DMEM: 16b x 64w
	SP_DMEM u_dmem (
		.Q   (dmem_q_fp16),
		.CLK (clk_fast  ),
		.CEN (~dmem_clk_en),
		.WEN (~dmem_wr_r ),
		.A   (dmem_addr_r),
		.D   (din_r        )
	);


	// CMEM: 16b x 64w
	wire [15:0] cmem_q_fp16;
	wire [15:0] cmem_din_fp16;
	SP_CMEM u_cmem (
		.Q   (cmem_q_fp16),
		.CLK (clk_fast^first_cycle_r),
		.CEN (~(first_cycle_r|dmem_clk_en)),
		.WEN (~cmem_wr   ),
		.A   (cmem_addr  ),
		.D   (cmem_din_fp16)
	);
	assign cmem_q_fp16i[16]    = cmem_q_fp16[15];
	assign cmem_q_fp16i[15:12] = cmem_q_fp16[14:11];
	assign cmem_q_fp16i[11]    = 1'b1;
	assign cmem_q_fp16i[10:0]  = cmem_q_fp16[10:0];

	assign cmem_din_fp16[15]    = cmem_din_FP16i[16];
	assign cmem_din_fp16[14:11] = cmem_din_FP16i[15:12];
	assign cmem_din_fp16[10:0]  = cmem_din_FP16i[10:0];

 	// REGFile: 29b x 59w
	SP_REGF u_regf (
		.Q   (regf_q_fp29i ),
		.CLK (regf_clk     ),
		.CEN (~rst_n       ),
		.WEN (~regf_wr_r   ),
		.A   (regf_addr_r  ),
		.D   (alumux_self_fp29i)
	);

`else

// DMEM: 16b x 64w
sp_sram #(
	.ADDR_WIDTH(6),
	.DATA_WIDTH(16)
) u_dmem (
	.clk  (dmem_clk   ),
	.addr (dmem_addr_r),
	.din  (din_r        ),
	.wr   (dmem_wr_r  ),
	.qout (dmem_q_fp16)
);

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

 // REGFile: 29b x 59w
sp_sram #(
	.ADDR_WIDTH(6),
	.DATA_WIDTH(29)
) u_regf (
	.clk  (regf_clk         ),
	.addr (regf_addr_r      ),
	.din  (alumux_self_fp29i),
	.wr   (regf_wr_r        ),
	.qout (regf_q_fp29i     )
);

`endif /* USE_VENDOR_MEMORY */



`ifdef DEBUGINFO
integer dbg_alu_clk_cnt;
reg     dbg_alu_outrdy;
always @(posedge alu_clk or posedge cycle_dinlatch) begin
	if(cycle_dinlatch) begin
		dbg_alu_clk_cnt <= 0;
		dbg_alu_outrdy <= 0;
	end else begin          
		dbg_alu_clk_cnt <= dbg_alu_clk_cnt + 1;
		if(dbg_alu_clk_cnt==3)  
			dbg_alu_outrdy <= 1;
	end
end 

`endif /* DEBUGINFO */

endmodule /* W4823_FIR */

/* vim: set ts=4 sw=4 noet */
