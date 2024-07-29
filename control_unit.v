
module control_unit(
    input [15:0]instr,
    output we, acc_control, load,
    output reg zx, nx, zy, ny, f, no,
    output [1:0] PC_ctrl
);
wire [4:0]opcode;

assign opcode = instr[14:10];

assign we = (opcode == 5'b10011);
assign acc_control = (opcode <= 5'd17);
assign load = (opcode <= 5'd18);

assign PC_ctrl = (opcode <= 5'd19)? 2'd0:
                (opcode == 5'd20)? 2'd1:
                (opcode == 5'd21)? 2'd2:
                (opcode == 5'd22)? 2'd3: 2'bxx;

always @ (*) begin
    case (opcode)
        5'd0: {zx, nx, zy, ny, f, no} = 6'b101000;
        5'd1: {zx, nx, zy, ny, f, no} = 6'b111111;
        5'd2: {zx, nx, zy, ny, f, no} = 6'b101110;
        5'd3: {zx, nx, zy, ny, f, no} = 6'b001010;
        5'd4: {zx, nx, zy, ny, f, no} = 6'b100010;
        5'd5: {zx, nx, zy, ny, f, no} = 6'b011010;
        5'd6: {zx, nx, zy, ny, f, no} = 6'b100011;
        5'd7: {zx, nx, zy, ny, f, no} = 6'b001111;
        5'd8: {zx, nx, zy, ny, f, no} = 6'b110011;
        5'd9: {zx, nx, zy, ny, f, no} = 6'b011111;
        5'd10: {zx, nx, zy, ny, f, no} = 6'b110111;
        5'd11: {zx, nx, zy, ny, f, no} = 6'b001110;
        5'd12: {zx, nx, zy, ny, f, no} = 6'b110010;
        5'd13: {zx, nx, zy, ny, f, no} = 6'b000010;
        5'd14: {zx, nx, zy, ny, f, no} = 6'b010011;
        5'd15: {zx, nx, zy, ny, f, no} = 6'b000111;
        5'd16: {zx, nx, zy, ny, f, no} = 6'b000000;
        5'd17: {zx, nx, zy, ny, f, no} = 6'b010101;
        default: {zx, nx, zy, ny, f, no} = 6'bx;
    endcase
end

endmodule