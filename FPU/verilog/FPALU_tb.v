// FPALU TB
// Excite the ALU with some randomly generated binary data
// To verify the output, use python script.
`timescale 1ns/1ps

module FPALU_tb();
  reg [31:0] a;
  reg [31:0] b;

//Built in real for verification of code
real result;
real a_real;
real b_real;
  reg clk;
  reg rst_n;
  reg add_muln;
  
  wire           din_uni_a_sgn  = a[28];
  wire [5:0]     din_uni_a_exp    = a[27:22];
  wire [21:0]    din_uni_a_man_dn = a[21:0];

  wire           din_uni_b_sgn  = b[28];
  wire [5:0]     din_uni_b_exp = b[27:22];
  wire [21:0]    din_uni_b_man_dn = b[21:0];   // Always Left-Aligned, Denorm

	wire          dout_uni_y_sgn;
	wire [5:0]    dout_uni_y_exp; 
	wire [21:0]   dout_uni_y_man_dn;

  FPALU dut( .rst_n(rst_n), 
               .clk(clk), 
               .din_uni_a_sgn(din_uni_a_sgn), 
               .din_uni_a_exp(din_uni_a_exp), 
               .din_uni_a_man_dn(din_uni_a_man_dn), 
               .din_uni_b_sgn(din_uni_b_sgn), 
               .din_uni_b_exp(din_uni_b_exp), 
               .din_uni_b_man_dn(din_uni_b_man_dn), 
               .add_muln(add_muln), 
               .dout_uni_y_sgn(dout_uni_y_sgn), 
               .dout_uni_y_exp(dout_uni_y_exp), 
            .dout_uni_y_man_dn(dout_uni_y_man_dn)
           );
           
  
initial begin
  a = {$random};
  b = {$random};
  rst_n    = 1;
  clk      = 0;
  add_muln = 0;

  #1;
  
  $dumpfile("dump.vcd");
   $dumpvars;
  //a_real = $bitstoshortreal(a);
  //b_real = $bitstoshortreal(b);

  $display("a %32b", a);
  $display("b %32b", b);
  $display("exp %6b",  din_uni_a_exp);
  $display("man %22b", din_uni_a_man_dn);

  #1 clk = ~clk;
  $display("exp %6b", dout_uni_y_exp);
  $display("man %22b", dout_uni_y_man_dn);
  #1 clk = ~clk;
  a = {$random};
  b = {$random};
  #1 clk = ~clk;
  $display("exp %6b", dout_uni_y_exp);
  $display("man %22b", dout_uni_y_man_dn);
  #1 clk = ~clk;
  a = {$random};
  b = {$random};
  #1 clk = ~clk;
  $display("exp %6b", dout_uni_y_exp);
  $display("man %22b", dout_uni_y_man_dn);
  #1 clk = ~clk;
  a = {$random};
  b = {$random};
  #1 clk = ~clk;
  $display("exp %6b", dout_uni_y_exp);
  $display("man %22b", dout_uni_y_man_dn);
  #1 clk = ~clk;
  a = {$random};
  b = {$random};
  #1 clk = ~clk;
  $display("exp %6b", dout_uni_y_exp);
  $display("man %22b", dout_uni_y_man_dn);
  #1 clk = ~clk;
  a = {$random};
  b = {$random};
  #1 clk = ~clk;
  #1 clk = ~clk;
  #1 clk = ~clk;
  #1 clk = ~clk;
  #1 clk = ~clk;
  #1 clk = ~clk;
  #1 clk = ~clk;
  $finish;
end
endmodule 