`timescale 1ns / 1ps

module barrelShifter_tb;

 // Inputs

 reg [15:0] A;

 reg [3:0] S;

 // Outputs

 wire [15:0] Y;

 // Instantiate the Unit Under Test (UUT)

 barrel_shifter_16 uut (

  .A(A), 

  .Y(Y), 

  .S(S)

  );

 initial begin

  // Initialize Inputs

  A    = 16'd0;

  S    = 4'd0;

  // Wait 100 ns for global reset to finish

  #100;

  // Add stimulus here

  A    = 16'd16;

  S = 4'd2;

  #20;

  Y    = 8'd4;

  S    = 4'd2;

 end

endmodule
