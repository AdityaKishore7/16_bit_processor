`timescale 1ns / 1ps
`include "top_file.v"
module test();

reg [7:0]x, y;
reg  zx, nx, zy, ny, f, no,  clk;
wire zr, ng;
wire [7:0]o;


top_file test_now(
    .clk(clk)
);


always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, test);

    #40;
    $finish;

end


endmodule