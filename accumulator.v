
module accumulator(
    input clk, load,
    input [15: 0]write_data,
    output reg [15:0]data
);

reg [15:0]next_data;

always @ (posedge clk)
    data <= next_data;

always @ (*) begin
    if(load)
        next_data = write_data;
    else
        next_data = data;
end

initial data = 16'd0;

endmodule