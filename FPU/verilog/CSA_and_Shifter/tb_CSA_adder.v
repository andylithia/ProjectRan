module tb_adder;

    // Inputs
    reg [15:0] A;
    reg [15:0] B;
    reg cin;
    // Outputs
    wire [15:0] S;
    wire cout;  
    integer i,j,error;

    // Instantiate the Unit Under Test (UUT)
    carry_select_adder uut (
        .A(A), 
        .B(B), 
        .cin(cin), 
        .S(S), 
        .cout(cout)
    );

//Stimulus block - all the input combinations are tested here.
//the number of errors are recorded in the signal named "error".
    initial begin
        // Initialize Inputs
        A = 0;
        B = 0;
        error = 0;
        //for carry in =0
        cin = 0;
      for(i=0;i<256;i=i+1) begin
            for(j=0;j<256;j=j+1) begin
                 A = i;
                 B = j;
                 #10;
                 if({cout,S} != (i+j)) 
                      error <= error + 1;
            end  
      end
        //for carry in =1
      cin = 1; 
      for(i=0;i<256;i=i+1) begin
            for(j=0;j<145;j=j+1) begin
                 A = i;
                 B = j;
                 #10;
                 if({cout,S} != (i+j+1)) 
                      error <= error + 1;
            end  
      end 
   end
    
endmodule