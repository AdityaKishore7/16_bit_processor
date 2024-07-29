module memory(
    input [9:0] instr_address,
    output [15:0] instr_out,
    input [9:0]data_address1, data_address2,
    output [15:0]data_out1, data_out2,
    input [9:0]write_data_address,
    input [15:0]write_data,
    input we,
    input clk
);

    reg [15:0]mem[0: 2**10 - 1];
    reg [15:0] temp_mem[0:622]; // Temporary array to store data.txt

    always @(posedge clk) begin
        if (we)
            mem[write_data_address] = write_data;
    end

    assign instr_out = mem[instr_address];

    assign data_out1 = mem[data_address1];
    assign data_out2 = mem[data_address2];

    initial begin
        $readmemh("Program.txt", mem);
        $readmemh("data.txt", temp_mem);
        integer i;
        for (i = 0; i < 623; i++) begin
            mem[401 + i] = temp_mem[i];
        end
    end
endmodule