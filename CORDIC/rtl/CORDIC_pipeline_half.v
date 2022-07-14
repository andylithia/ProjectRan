module CORDIC_pipeline_stage_2 #(
    parameter Nxy = 32,
    parameter Nz  = 32,
    parameter stn = 0
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
reg [Nz-1:0] zROM0;
reg [Nz-1:0] zROM1;
always @* begin
    case (stn)
        00: zROM0 = 32'b10110100000000000000000000000000;
        01: zROM0 = 32'b00111000001001010001110100000001;
        02: zROM0 = 32'b00001110010011100010101010011001;
        03: zROM0 = 32'b00000011100101001010100001101010;
        04: zROM0 = 32'b00000000111001010010111010010100;
        05: zROM0 = 32'b00000000001110010100101110110111;
        06: zROM0 = 32'b00000000000011100101001011101110;
        07: zROM0 = 32'b00000000000000111001010010111011;
        08: zROM0 = 32'b00000000000000001110010100101110;
        09: zROM0 = 32'b00000000000000000011100101001011;
        10: zROM0 = 32'b00000000000000000000111001010010;
        11: zROM0 = 32'b00000000000000000000001110010100;
        12: zROM0 = 32'b00000000000000000000000011100101;
        13: zROM0 = 32'b00000000000000000000000000111001;
        14: zROM0 = 32'b00000000000000000000000000001110;
        15: zROM0 = 32'b00000000000000000000000000000011;
    endcase
    case (stn)
        00: zROM1 = 32'b01101010010000101001110011000110;
        01: zROM1 = 32'b00011100100000000000010001001001;
        02: zROM1 = 32'b00000111001010001101111001010011;
        03: zROM1 = 32'b00000001110010100101101101011110;
        04: zROM1 = 32'b00000000011100101001011101100110;
        05: zROM1 = 32'b00000000000111001010010111011011;
        06: zROM1 = 32'b00000000000001110010100101110111;
        07: zROM1 = 32'b00000000000000011100101001011101;
        08: zROM1 = 32'b00000000000000000111001010010111;
        09: zROM1 = 32'b00000000000000000001110010100101;
        10: zROM1 = 32'b00000000000000000000011100101001;
        11: zROM1 = 32'b00000000000000000000000111001010;
        12: zROM1 = 32'b00000000000000000000000001110010;
        13: zROM1 = 32'b00000000000000000000000000011100;
        14: zROM1 = 32'b00000000000000000000000000000111;
        15: zROM1 = 32'b00000000000000000000000000000001;
    endcase
end

wire dir  = zi [Nz-1]; // Direction of CORDIC rotation, input
wire diri = zii[Nz-1]; // Direction of CORDIC rotation, intermediate

reg signed [Nxy-1:0] xo_r, yo_r;
reg signed [Nxy-1:0] xn, yn;    // wire-type
reg signed [Nz-1 :0] zo_r, zn;

reg signed [Nxy-1:0] xii, yii;  // Intermediate
reg signed [Nz-1 :0] zii;
always @ (posedge clk) begin
    {xo_r, yo_r, zo_r} <= {xii, yii, zii};
end

always @* begin
    if (dir==0) begin
        xn = xi - (yi>>>(stn*2));
        yn = yi + (xi>>>(stn*2));
        zn = zi - zROM0;
    end else begin
        xn = xi + (yi>>>(stn*2));
        yn = yi - (xi>>>(stn*2));
        zn = zi + zROM0;
    end

    if (diri == 0) begin
        xii = xn - (yi>>>(stn*2+1));
        yii = yn + (xi>>>(stn*2+1));
        zii = zn - zROM1;
    end else begin
        xii = xn + (yi>>>(stn*2+1));
        yii = yn - (xi>>>(stn*2+1));
        zii = zn + zROM1;
    end
end

endmodule /* CORDIC_pipeline_stage_2 */