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
			if(cycle_cnt_r==8'd64) begin	// Constant MUL16i
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


wire dmem_wr;
wire alu_clk;
wire dmem_rd;
wire regf_wr;
wire regf_rd;
wire [5:0]	dmem_addr;
wire [5:0]	regf_addr;



endmodule /* W4823_FIR */