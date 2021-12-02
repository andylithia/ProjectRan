// Integratd Clock Gating Cell
// 
module icgc (

	input		CK,
	input 		E,
	output		ECK
);

reg   clkg_en;
always @* if(CK) clkg_en = E;
assign ECK = CK & clkg_en;

endmodule /* icgc */
/* vim: set ts=4 sw=4 noet */
