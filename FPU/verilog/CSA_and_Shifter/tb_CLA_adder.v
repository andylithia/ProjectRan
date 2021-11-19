 module tb_CLA16;

   reg [15:0] A;
   reg [15:0] B;
   reg Ci;
   wire [15:0] S;
   wire Co;
   wire PG;
   wire GG;

   wire [15:0] G;
   wire [15:0] P;
   wire [15:1] C;

 //CLA4 u0(A, B, Ci, S, PG, GG);
 CLA16 u1(A, B, Ci, S, Co);

   initial begin
       $dumpfile("dump.vcd");
     $dumpvars(0);
   A = 16'hAAAA;//16'b0000_1010_1010_1000;
   B = 16'h5555;//16'b0000_0100_0000_0000;
   Ci = 1;

   #100

   A = 16'hAAAA;//16'b0000_0000_1010_1000;
   B = 16'h5555;//16'b0000_0100_0110_0000;
   Ci = 0;

   #100
   A = 16'd1552;
   B = 16'd0713;
   Ci = 0;

   end

   endmodule