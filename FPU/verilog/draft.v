// MULTIPLIER: Partial Product Generation 
// The original plan was to use Booth Radix-4 Wallace Tree.
// It might be an overkill: producing overcomplicated logic, which may increase power
// Simplify it to wallace tree only, the summation can start in the first cycle.
wire [ML_MANSIZE+2:0] s1_wt_lhs = din_uni_a_man_dn[AL_MANSIZE-1:AL_MANSIZE-ML_MANSIZE];
wire [ML_MANSIZE+2:0] s1_wt_rhs = din_uni_b_man_dn[AL_MANSIZE-1:AL_MANSIZE-ML_MANSIZE];
// The advantage of using booth-4 is that the number of pps can be reduced to 6
wire [10:0]		s1_wt_pp0 = s1_wt_lhs & s1_wt_rhs[0];
wire [10:0]		s1_wt_pp1 = s1_wt_lhs & s1_wt_rhs[1];
wire [10:0]		s1_wt_pp2 = s1_wt_lhs & s1_wt_rhs[2];
wire [10:0]		s1_wt_pp3 = s1_wt_lhs & s1_wt_rhs[3];
wire [10:0]		s1_wt_pp4 = s1_wt_lhs & s1_wt_rhs[4];
wire [10:0]		s1_wt_pp5 = s1_wt_lhs & s1_wt_rhs[5];
wire [10:0]		s1_wt_pp6 = s1_wt_lhs & s1_wt_rhs[6];
wire [10:0]		s1_wt_pp7 = s1_wt_lhs & s1_wt_rhs[7];
wire [10:0]		s1_wt_pp8 = s1_wt_lhs & s1_wt_rhs[8];
wire [10:0]		s1_wt_pp9 = s1_wt_lhs & s1_wt_rhs[9];
wire [10:0]		s1_wt_ppa = s1_wt_lhs & s1_wt_rhs[10];