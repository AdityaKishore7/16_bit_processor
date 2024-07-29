`timescale 1ns / 1ps
module alu(
    input [15:0] x, y,
    input zx, nx, zy, ny, f, no,
    output zr, ng,
    output reg [15:0]o
);

wire [5:0]ctrl_sig;
assign ctrl_sig = {zx, nx, zy, ny, f, no};
always  @ (*) begin
    o = 16'bx;
    case(ctrl_sig)

        6'b010101: o = x | y;
        6'b000000: o = x & y;
        6'b000111: o = y - x;
        6'b010011: o = x - y;
        6'b000010: o = x + y;
        6'b110010: o = y - 16'd1;
        6'b001110: o = x - 16'd1;
        6'b110111: o = y + 16'd1;
        6'b011111: o = x + 16'd1;
        6'b110011: o = -y;
        6'b001111: o = -x;
        6'b100011: o = ~y;
        6'b011010: o = ~x;
        6'b100010: o = y;
        6'b001010: o = x;
        6'b101110: o = -(16'd1);
        6'b111111: o = 16'd1;
        6'b101000: o = 16'd0;
        endcase
end

assign zer = ~|o;
assign ng = o[15];


endmodule
