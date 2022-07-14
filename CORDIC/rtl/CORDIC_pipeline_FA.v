`timescale 1ns/1ps

// Fully-Parallel Implementation
// Due to the lack of digit dependency, this can be turned into bit-serial easily
// 32 stage is probably too-much, consider 16-stage implementation
module CORDIC_pipeline_stage #(
    parameter Nxy = 32,
    parameter Nz  = 32,
    parameter stn = 0  // Stage position
)(
    // input            reset_n, // Not implemented
    input            clk,
    input  [Nxy-1:0] xi,
    input  [Nxy-1:0] yi,
    input  [Nz-1 :0] zi,
    output [Nxy-1:0] xo_r,
    output [Nxy-1:0] yo_r,
    output [Nz-1 :0] zo_r
);
// In the pipeline impl. this is hard-wired
reg [Nz-1:0] zROM;
always @* begin
    case (stn)
        00: zROM = 32'b10110100000000000000000000000000;
        01: zROM = 32'b01101010010000101001110011000110;
        02: zROM = 32'b00111000001001010001110100000001;
        03: zROM = 32'b00011100100000000000010001001001;
        04: zROM = 32'b00001110010011100010101010011001;
        05: zROM = 32'b00000111001010001101111001010011;
        06: zROM = 32'b00000011100101001010100001101010;
        07: zROM = 32'b00000001110010100101101101011110;
        08: zROM = 32'b00000000111001010010111010010100;
        09: zROM = 32'b00000000011100101001011101100110;
        10: zROM = 32'b00000000001110010100101110110111;
        11: zROM = 32'b00000000000111001010010111011011;
        12: zROM = 32'b00000000000011100101001011101110;
        13: zROM = 32'b00000000000001110010100101110111;
        14: zROM = 32'b00000000000000111001010010111011;
        15: zROM = 32'b00000000000000011100101001011101;
        16: zROM = 32'b00000000000000001110010100101110;
        17: zROM = 32'b00000000000000000111001010010111;
        18: zROM = 32'b00000000000000000011100101001011;
        19: zROM = 32'b00000000000000000001110010100101;
        20: zROM = 32'b00000000000000000000111001010010;
        21: zROM = 32'b00000000000000000000011100101001;
        22: zROM = 32'b00000000000000000000001110010100;
        23: zROM = 32'b00000000000000000000000111001010;
        24: zROM = 32'b00000000000000000000000011100101;
        25: zROM = 32'b00000000000000000000000001110010;
        26: zROM = 32'b00000000000000000000000000111001;
        27: zROM = 32'b00000000000000000000000000011100;
        28: zROM = 32'b00000000000000000000000000001110;
        29: zROM = 32'b00000000000000000000000000000111;
        30: zROM = 32'b00000000000000000000000000000011;
        31: zROM = 32'b00000000000000000000000000000001;
    endcase
end

wire dir = zi[Nz-1]; // Direction of CORDIC rotation
reg signed [Nxy-1:0] xo_r, yo_r;
reg signed [Nxy-1:0] xn, yn;    // wire-type
reg signed [Nz-1 :0] zo_r, zn;
always @ (posedge clk) begin
    {xo_r, yo_r, zo_r} <= {xn, yn, zn};
end

always @* begin
    if (dir==0) begin
        xn = xi - (yi>>>stn);
        yn = yi + (xi>>>stn);
        zn = zi - zROM;
    end else begin
        xn = xi + (yi>>>stn);
        yn = yi - (xi>>>stn);
        zn = zi + zROM;
    end
end

endmodule /* CORDIC_pipeline_stage */


// Pipeline
module CORDIC_pipeline#(
    parameter Nxy = 32,
    parameter Nz  = 32
)(
    input                       clk,
    input      signed [Nz-1 :0] zi,
    output reg signed [Nxy-1:0] yo,
    output reg signed [Nxy-1:0] xo
);

// Stage connection
wire signed [Nxy-1:0] xc [Nz-1:0];
wire signed [Nxy-1:0] yc [Nz-1:0];
wire signed [Nz-1 :0] zc [Nz-1:0];

// Correction Factor (1/K)
assign xc[0] = 'b00000010011011011101001110110110;
assign yc[0] = 0;

// Quadrant Correction
// The angle correction itself is a stage
// 90 degree constant
wire [Nz-1:0] deg90  = ;// TBD
wire [Nz-1:0] deg180 = ;// TBD
wire [Nz-1:0] deg270 = ;// TBD
wire [Nz-1:0] deg360 = ;// TBD
wire [Nz-1:0] zs = zi - deg180;


// Well you should try serialized method
always @* begin
    if(((zs[Nz-1]==1) && (zs<deg270)) ||
       ((zs[Nz-1]==0) && (zs>deg90))) begin

        xo = ~(xc[Nz-1]-1);
        yo = ~(yc[Nz-1]-1);
        if(zs[Nz-1]==1) 
            zc[0] = zs + deg180;
    end else begin
        xo = xc[Nz-1];
        yo = yc[Nz-1];
    end
end

genvar gi;
generate
    for(gi=0;gi<Nz;gi=gi+1) begin: gen_pipeline
        CORDIC_pipeline_stage #(.i(gi)) stage_i (
            .clk(clk),
            .xi(xc[gi]), .xo(xc[gi+1]),
            .yi(yc[gi]), .yo(yc[gi+1]),
            .zi(zc[gi]), .zo(zc[gi+1])
        );
    end
endgenerate


endmodule /* CORDIC_pipeline */
