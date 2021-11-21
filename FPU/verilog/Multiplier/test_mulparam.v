`timescale 1ns/1ps
`define out_fn "./multiplier.out"

module testbench();

parameter width = 11;

reg [width-1:0] a;
reg [width-1:0] b;
reg clock;

wire [2*width-1:0] p;

integer j, k;
integer out_file;

mulparam mul_0( .p(p), .a(a), .b(b), .clock(clock) );

initial clock = 0;
always #5 clock = ~ clock;

initial
begin

	out_file = $fopen(`out_fn, "w");

	a=0;
	b=0;
	for (j=1; j<=2**width-1; j=j+1)
		for(k=1; k<=2**width-1; k=k+1)
		begin
			a=j;
			b=k;
			#20 $display("%d * %d = %d", a, b, p);
			$fwrite(out_file, "%d * %d = %d\n", a, b, p);
		end

	$fclose(out_file);
end
endmodule
