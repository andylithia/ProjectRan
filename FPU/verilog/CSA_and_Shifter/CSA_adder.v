module carry_select_adder
        (   input [15:0] A,B,
            input cin,
            output [15:0] S,
            output cout
            );
        

wire [15:0] temp0,temp1,carry0,carry1;

//for carry 0
fulladder fa00(A[0],B[0],1'b0,temp0[0],carry0[0]);
fulladder fa01(A[1],B[1],carry0[0],temp0[1],carry0[1]);
fulladder fa02(A[2],B[2],carry0[1],temp0[2],carry0[2]);
fulladder fa03(A[3],B[3],carry0[2],temp0[3],carry0[3]);
fulladder fa04(A[4],B[4],carry0[3],temp0[4],carry0[4]);
fulladder fa05(A[5],B[5],carry0[4],temp0[5],carry0[5]);
fulladder fa06(A[6],B[6],carry0[5],temp0[6],carry0[6]);
fulladder fa07(A[7],B[7],carry0[6],temp0[7],carry0[7]);
fulladder fa08(A[8],B[8],carry0[7],temp0[8],carry0[8];
fulladder fa09(A[9],B[9],carry0[8],temp0[9],carry0[9]);
fulladder fa10(A[10],B[10],carry0[9],temp0[10],carry0[10]);
fulladder fa11(A[11],B[11],carry0[10],temp0[11],carry0[11]);
fulladder fa12(A[12],B[12],carry0[11],temp0[12],carry0[12]);
fulladder fa13(A[13],B[13],carry0[12],temp0[13],carry0[13]);
fulladder fa14(A[14],B[14],carry0[13],temp0[14],carry0[14]);
fulladder fa15(A[15],B[15],carry0[14],temp0[15],carry0[15]);



//for carry 1
fulladder fa100(A[0],B[0],1'b1,temp1[0],carry1[0]);
fulladder fa101(A[1],B[1],carry1[0],temp1[1],carry1[1]);
fulladder fa102(A[2],B[2],carry1[1],temp1[2],carry1[2]);
fulladder fa103(A[3],B[3],carry1[2],temp1[3],carry1[3]);
fulladder fa104(A[4],B[4],carry1[3],temp1[4],carry1[4]);
fulladder fa105(A[5],B[5],carry1[4],temp1[5],carry1[5]);
fulladder fa106(A[6],B[6],carry1[5],temp1[6],carry1[6]);
fulladder fa107(A[7],B[7],carry1[6],temp1[7],carry1[7]);
fulladder fa108(A[8],B[8],carry1[7],temp1[8],carry1[8];
fulladder fa109(A[9],B[9],carry1[8],temp1[9],carry1[9]);
fulladder fa110(A[10],B[10],carry1[9],temp1[10],carry1[10]);
fulladder fa111(A[11],B[11],carry1[10],temp1[11],carry1[11]);
fulladder fa112(A[12],B[12],carry1[11],temp1[12],carry1[12]);
fulladder fa113(A[13],B[13],carry1[12],temp1[13],carry1[13]);
fulladder fa114(A[14],B[14],carry1[13],temp1[14],carry1[14]);
fulladder fa115(A[15],B[15],carry1[14],temp1[15],carry1[15]);


//mux for carry
multiplexer2 mux_carry(carry0[15],carry1[15],cin,cout);
//mux's for sum
multiplexer2 mux_sum0(temp0[0],temp1[0],cin,S[0]);
multiplexer2 mux_sum1(temp0[1],temp1[1],cin,S[1]);
multiplexer2 mux_sum2(temp0[2],temp1[2],cin,S[2]);
multiplexer2 mux_sum3(temp0[3],temp1[3],cin,S[3]);
multiplexer2 mux_sum4(temp0[4],temp1[4],cin,S[4]);
multiplexer2 mux_sum5(temp0[5],temp1[5],cin,S[5]);
multiplexer2 mux_sum6(temp0[6],temp1[6],cin,S[6]);
multiplexer2 mux_sum7(temp0[7],temp1[7],cin,S[7]);
multiplexer2 mux_sum8(temp0[8],temp1[8],cin,S[8]);
multiplexer2 mux_sum9(temp0[9],temp1[9],cin,S[9]);
multiplexer2 mux_sum10(temp0[10],temp1[10],cin,S[10]);
multiplexer2 mux_sum11(temp0[11],temp1[11],cin,S[11]);
multiplexer2 mux_sum12(temp0[12],temp1[12],cin,S[12]);
multiplexer2 mux_sum13(temp0[13],temp1[13],cin,S[13]);
multiplexer2 mux_sum14(temp0[14],temp1[14],cin,S[14]);
multiplexer2 mux_sum15(temp0[15],temp1[15],cin,S[15]);

endmodule 





module multiplexer2
        (   input i0,i1,sel,
            output reg bitout
            );

always@(i0,i1,sel)
begin
if(sel == 0)
    bitout = i0;
else
    bitout = i1; 
end

endmodule




module fulladder
        (   input a,b,cin,
            output sum,carry
            );

assign sum = a ^ b ^ cin;
assign carry = (a & b) | (cin & b) | (a & cin);

endmodule