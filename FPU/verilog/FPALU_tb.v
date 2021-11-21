`timescale 1ns/1ps
`define SD #0.010

module testbench();

	reg           rst_n;
	reg           clk;
	
	reg           din_uni_a_sgn;
	reg [5:0]     din_uni_a_exp;
	reg [21:0]    din_uni_a_man_dn;   // Always Left-Aligned, Denorm

	reg           din_uni_b_sgn;
	reg [5:0]     din_uni_b_exp;
	reg [21:0]    din_uni_b_man_dn;   // Always Left-Aligned, Denorm

	reg           add_muln;           // 1: Adder Mode, 0: Multiplier Mode
	wire          dout_uni_y_sgn;
	wire [5:0]    dout_uni_y_exp; 
	wire [21:0]   dout_uni_y_man_dn;

	bit [15:0]    a; //Number random generated
 	bit [15:0]    b; 
        wire [31:0]   p;
        wire cout;
	wire [15:0]   sum;


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
               .dout_uni_y_man_dn(dout_uni_y_man_dn);

	initial begin
//	$dumpfile("./alu.vcd");
//	$dumpvars(0,testbench.dut);  
	clk = 0;
	rst_n = 0; 
        numerrors = 0;
	sum = 16'b0;
	p = 16'b0;
	end



// clock genration 
    always 
       #5 clk = ~clk;


// first reset the system up to 5 cloks
rst_n = 1'b1;
repeat(5) @ (posedge clk);

rst_n = 1'b0;


// generate random number for a and b
    initial 
        begin      
		assert(std::randomize(a));
		$display("a=%016b", a);
		assert(std::randomize(b));
		$display("b=%016b", b);				

// random two numbers add together by cla or multiply
    always @ (add_muln);
    if add_muln = 1		
    cla_adder add(.in1(a), .in2(b), .carry_in(0), .sum(sum), .carry_out(cout));
    else
    mulparam  mul(.p(p), .a(a), .b(b), .clock(clk));
    end 


//NEED YOU TO ADD CALLING FPALU FOR ADDING AND MULTI HERE: OUTPUT VARIABLE DOWN HERE IS out_p AND out_sum FOR MULTIPLIER AND ADDER

        begin
        $display("input1: " , a, " , input_2: " , b, ", Sum answer:", sum ", Product answer:", p);
        @ (posedge clk);
        if(sum != out_sum)  
        $display ("The results DO NOT match in sum :(");
        if(p != out_p)  
        $display ("The results DO NOT match in Product :(");
        else 
        $display ("The results DO match :)");
    	end

	$dumpall;
	$dumpflush;
	$finish;
	end 

endmodule 
