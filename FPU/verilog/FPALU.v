

//            FORMAT  SIGN  EXP  MANTISSA  WIDTH
//  RAW IEEE  FP16    1     5    10        16
//  INPUT     FP16i   1     5    11        17
//  POST MUL  FP29i   1     6    22        29
//  POST ACC  FP29i   1     6    22        29
//  OUTPUT    FP16    1     5    10        16 

module FPALU (
    input           rst_n,
    input           clk,
    
    input           din_uni_a_sgn,
    input [5:0]     din_uni_a_exp,
    input [21:0]    din_uni_a_man_dn,   // Always Left-Aligned, Denorm

    input           din_uni_b_sgn,
    input [5:0]     din_uni_b_exp,
    input [21:0]    din_uni_b_man_dn,   // Always Left-Aligned, Denorm

    input           add_muln,           // 1: Adder Mode, 0: Multiplier Mode
    output          dout_uni_y_sgn,
    output [5:0]    dout_uni_y_exp, 
    output [21:0]   dout_uni_y_man_dn

);
// ----- PIPELINE STAGE 1 ----- 
// ADDER SECTION
// Exponent Compare
wire [6:0] s1_ea_sub_eb = {1'b0,din_uni_a_exp} - {1'b0,din_uni_b_exp};
wire       s1_ea_gt_eb  = ~s1_ea_sub_eb[6];
wire [5:0] s1_ea_sub_eb_abs = s1_ea_gt_eb?s1_ea_sub_eb[5:0]:{~s1_ea_sub_eb+1'b1}[5:0];
// If the difference is too large, skip the shifting entirely
wire       s1_exp_largediff = s1_ea_sub_eb_abs > 22;


// ----- PIPELINE STAGE 2 ----- 
// ADDER SECTION
reg  [6:0] s2_ea_sub_eb_r;
reg  [5:0] s2_ea_sub_eb_abs_r;  // Absolute Value, for the shifter
reg        s2_ea_gt_eb_r;
reg        s2_exp_largediff_r;  // Deactivate the shifter 
always @(posedge clk) begin
    s2_exp_largediff_r <= s1_exp_largediff;
end

// Operand MUX
reg  [21:0] s2_mmux21_larger_r;
reg  [21:0] s2_mmux22_smaller_r;
always @(posedge clk) begin
    if(s1_ea_gt_eb) begin
        s2_mmux21_larger  <= din_uni_a_man_dn;
        if(s1_exp_largediff) // Keep & Bypass
            s2_mmux22_smaller_r <= s2_mmux22_smaller_r;
        else                 // Update
            s2_mmux21_smaller_r <= din_uni_b_man_dn;
    end else begin
        s2_mmux21_larger  <= din_uni_b_man_dn;         
        if(s1_exp_largediff) // Keep & Bypass
            s2_mmux22_smaller_r <= s2_mmux22_smaller_r;
        else                 // Update
            s2_mmux21_smaller_r <= din_uni_a_man_dn;
    end
end

// Shifter & Mantissa Inversion Implementation
reg [21:0] s2_mmux23_smaller_preinv;
reg [21:0] s2_mmux23_smaller_preinv_last_r;
reg [21:0] s2_mmux24_smaller_out;
always @* begin
    if(s2_exp_largediff_r) begin
        s2_mmux23_smaller_preinv = 0;
        s2_mmux24_smaller_out    = 0;
    end else begin
        s2_mmux23_smaller_preinv = {{s2_mmux21_smaller_r,22'b0}>>(s2_ea_sub_eb_abs_r)}[21:0];
    end
end

assign s2_mmux24_smaller_out

// Mantissa Inversion
reg [21:0] s2_mmux24_smaller_postinv; 
always @* begin
    if(s2_submode_r) s2_mmux24_smaller_postinv = ~s2_mmux23_smaller_out;
    else             s2_mmux24_smaller_postinv = 

end


// ----- PIPELINE STAGE 3 ----- 
reg  [6:0] s3_ea_sub_eb_r;
reg        s3_ea_gt_eb_r;



// ----- PIPELINE STAGE 4 ----- 

// ----- PIPELINE STAGE 5 ----- 




endmodule /* FPALU */