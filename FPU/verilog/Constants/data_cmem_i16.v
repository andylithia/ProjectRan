module data_cmem_i16(
	input [5:0]         a,
	output reg [15:0]   q   
);
always @* begin
	case(addr) 
	6'd0: q = 16'hFFFF;
	6'd1: q = 16'hFFFF;
	6'd2: q = 16'h0001;
	6'd3: q = 16'h0003;
	6'd4: q = 16'h0004;
	6'd5: q = 16'hFFFF;
	6'd6: q = 16'hFFF6;
	6'd7: q = 16'hFFF0;
	6'd8: q = 16'hFFFB;
	6'd9: q = 16'h0017;
	6'd10: q = 16'h002E;
	6'd11: q = 16'h001E;
	6'd12: q = 16'hFFDD;
	6'd13: q = 16'hFF98;
	6'd14: q = 16'hFF9E;
	6'd15: q = 16'h0016;
	6'd16: q = 16'h00BC;
	6'd17: q = 16'h00F0;
	6'd18: q = 16'h003A;
	6'd19: q = 16'hFEE9;
	6'd20: q = 16'hFE1A;
	6'd21: q = 16'hFEE9;
	6'd22: q = 16'h0141;
	6'd23: q = 16'h0365;
	6'd24: q = 16'h0301;
	6'd25: q = 16'hFF3C;
	6'd26: q = 16'hFA44;
	6'd27: q = 16'hF89E;
	6'd28: q = 16'hFE3A;
	6'd29: q = 16'h0B2B;
	6'd30: q = 16'h1A91;
	6'd31: q = 16'h2500;
	6'd32: q = 16'h2500;
	6'd33: q = 16'h1A91;
	6'd34: q = 16'h0B2B;
	6'd35: q = 16'hFE3A;
	6'd36: q = 16'hF89E;
	6'd37: q = 16'hFA44;
	6'd38: q = 16'hFF3C;
	6'd39: q = 16'h0301;
	6'd40: q = 16'h0365;
	6'd41: q = 16'h0141;
	6'd42: q = 16'hFEE9;
	6'd43: q = 16'hFE1A;
	6'd44: q = 16'hFEE9;
	6'd45: q = 16'h003A;
	6'd46: q = 16'h00F0;
	6'd47: q = 16'h00BC;
	6'd48: q = 16'h0016;
	6'd49: q = 16'hFF9E;
	6'd50: q = 16'hFF98;
	6'd51: q = 16'hFFDD;
	6'd52: q = 16'h001E;
	6'd53: q = 16'h002E;
	6'd54: q = 16'h0017;
	6'd55: q = 16'hFFFB;
	6'd56: q = 16'hFFF0;
	6'd57: q = 16'hFFF6;
	6'd58: q = 16'hFFFF;
	6'd59: q = 16'h0004;
	6'd60: q = 16'h0003;
	6'd61: q = 16'h0001;
	6'd62: q = 16'hFFFF;
	6'd63: q = 16'hFFFF;
	endcase
end
endmodule /* data_cmem_i16 */
/* vim: set ts=4 sw=4 noet */