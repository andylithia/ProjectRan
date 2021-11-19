

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
    input [21:0]    din_uni_a_man_dn,   // Always Left-Aligned

    input           din_uni_b_sgn,
    input [5:0]     din_uni_b_exp,
    input [21:0]    din_uni_b_man_dn,   // Always Left-Aligned

    input           add_muln,           // 1: Adder Mode, 0: Multiplier Mode
    output          dout_uni_y_sgn,
    output [5:0]    dout_uni_y_exp, 
    output [21:0]   dout_uni_y_man_dn

);
    // PIPELINE STAGE 1


    // PIPELINE STAGE 2


    // PIPELINE STAGE 3


    // PIPELINE STAGE 4


    // PIPELINE STAGE 5



endmodule /* FPALU */