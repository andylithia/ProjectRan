
`timescale 1ns/1fs

module data_cmem_fp16(
	input [5:0]         a,
	output reg [15:0]   q   
);
always @* begin
	case(a) 
	6'd0: q = 16'h82DC;
	6'd1: q = 16'h8114;
	6'd2: q = 16'h0133;
	6'd3: q = 16'h05F3;
	6'd4: q = 16'h07BE;
	6'd5: q = 16'h8144;
	6'd6: q = 16'h8D16;
	6'd7: q = 16'h8FEA;
	6'd8: q = 16'h891D;
	6'd9: q = 16'h11B8;
	6'd10: q = 16'h15BE;
	6'd11: q = 16'h138A;
	6'd12: q = 16'h9448;
	6'd13: q = 16'h9A76;
	6'd14: q = 16'h9A21;
	6'd15: q = 16'h118A;
	6'd16: q = 16'h1DE2;
	6'd17: q = 16'h1F7D;
	6'd18: q = 16'h173D;
	6'd19: q = 16'hA05D;
	6'd20: q = 16'hA398;
	6'd21: q = 16'hA05C;
	6'd22: q = 16'h2103;
	6'd23: q = 16'h26CA;
	6'd24: q = 16'h2601;
	6'd25: q = 16'h9E1E;
	6'd26: q = 16'hA9BC;
	6'd27: q = 16'hAB62;
	6'd28: q = 16'hA318;
	6'd29: q = 16'h2D95;
	6'd30: q = 16'h32A4;
	6'd31: q = 16'h34A0;
	6'd32: q = 16'h34A0;
	6'd33: q = 16'h32A4;
	6'd34: q = 16'h2D95;
	6'd35: q = 16'hA318;
	6'd36: q = 16'hAB62;
	6'd37: q = 16'hA9BC;
	6'd38: q = 16'h9E1E;
	6'd39: q = 16'h2601;
	6'd40: q = 16'h26CA;
	6'd41: q = 16'h2103;
	6'd42: q = 16'hA05C;
	6'd43: q = 16'hA398;
	6'd44: q = 16'hA05D;
	6'd45: q = 16'h173D;
	6'd46: q = 16'h1F7D;
	6'd47: q = 16'h1DE2;
	6'd48: q = 16'h118A;
	6'd49: q = 16'h9A21;
	6'd50: q = 16'h9A76;
	6'd51: q = 16'h9448;
	6'd52: q = 16'h138A;
	6'd53: q = 16'h15BE;
	6'd54: q = 16'h11B8;
	6'd55: q = 16'h891D;
	6'd56: q = 16'h8FEA;
	6'd57: q = 16'h8D16;
	6'd58: q = 16'h8144;
	6'd59: q = 16'h07BE;
	6'd60: q = 16'h05F3;
	6'd61: q = 16'h0133;
	6'd62: q = 16'h8114;
	6'd63: q = 16'h80DC;
	endcase
end

endmodule /* data_cmem_fp16 */
/* vim: set ts=4 sw=4 noet */