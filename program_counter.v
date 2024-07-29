module program_counter(
    input clk,
    input [9: 0]PCNext,
    output reg [9:0] PC
);

always  @ (posedge clk)
    PC <= PCNext;

initial PC = 10'd0;

endmodule