`include "accumulator.v"
`include "alu.v"
`include "control_unit.v"
`include "memory.v"
`include "instruction_register.v"
`include "program_counter.v"


module top_file(
    input clk
);
reg [9: 0]PCNext;
wire [15:0]result;
wire[9:0] PC;
wire[15:0] instr_from_mem, instr_from_reg, acc_in, acc_out;
wire [15:0] data_mem_out1, data_mem_out2, data_mem_mux_out;


wire we, addressing_mode, acc_control, load, zx, nx, zy, ny, f, no;//control signals
wire [1:0] PC_ctrl; // control signal
wire is_result_zero, is_result_neg;

program_counter pc(
    .clk(clk),
    .PCNext(PCNext),
    .PC(PC)
);


memory both_mem(
    .instr_address(PC),
    .instr_out(instr_from_mem),
    .data_address1(instr_from_reg[9:0]),
    .data_out1(data_mem_out1),
    .data_address2(data_mem_out1[9:0]),
    .data_out2(data_mem_out2),
    .write_data_address(addressing_mode? data_mem_out1[9:0]:instr_from_reg[9:0]),
    .write_data(acc_out),
    .we(we),
    .clk(clk)
);

instruction_register ins_reg(
    .clk(clk),
    .write_instr(instr_from_mem),
    .instr(instr_from_reg)
);


assign addressing_mode = instr_from_reg[15];

assign data_mem_mux_out = addressing_mode? data_mem_out2: data_mem_out1;

assign acc_in = acc_control? result: data_mem_mux_out;

accumulator acc(
    .clk(clk),
    .load(load),
    .write_data(acc_in),
    .data(acc_out)
);

alu alu_16(
    .x(acc_out), .y(data_mem_mux_out),
    .zx(zx), .nx(nx), .zy(zy), .ny(ny), .f(f), .no(no),
    .zr(is_result_zero), .ng(is_result_neg), .o(result)
);

always @ (*) begin
    PCNext = PC + 10'd1;
    case(PC_ctrl)
        0: PCNext = PC + 10'd1;
        1: PCNext = instr_from_reg[9:0];
        2: PCNext = (is_result_zero)? acc_out[9:0]: PC + 10'd1;
        3: PCNext = (is_result_neg)? acc_out[9:0]: PC + 10'd1;
    endcase
end

control_unit controller(
    .instr(instr_from_reg),
    .we(we),
    .acc_control(acc_control), .load(load),
    .zx(zx), .nx(nx), .zy(zy), .ny(ny), .f(f), .no(no),
    .PC_ctrl(PC_ctrl)
);


endmodule