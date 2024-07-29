module instruction_register(
    input clk,
    input [15:0] write_instr,
    output reg [15:0] instr
);

always @ (posedge clk) begin
    instr <= write_instr;
end

endmodule