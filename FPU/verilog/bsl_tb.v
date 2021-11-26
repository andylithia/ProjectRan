`timescale 1ns/1ps

module bsl_tb;

reg [4:0] a;
reg [31:0] b;
initial begin
    $dumpfile("bsl_tb.vcd");
    $dumpvars;
    a = 0;
    b = 32'hDEADBEEF;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    #1 a=a+1;
    $finish;
end

wire [31:0] dout_sr;
wire [31:0] dout_sr_ref = b>>a;
wire [31:0] dout_sl;
wire [31:0] dout_sl_ref = b<<a;

bsr #(.SWIDTH(5)) dur(
    .din(b),
    .s(a),
    .filler(1'b0),
    .dout(dout_sr)
);

bsl #(.SWIDTH(5)) dul(
    .din(b),
    .s(a),
    .filler(1'b0),
    .dout(dout_sl)
);

endmodule /* bsl_tb */