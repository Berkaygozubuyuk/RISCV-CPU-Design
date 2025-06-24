`include "single_c_processor.v"
`include "instr_memory.v"
`include "data_memory.v"

module top(
    input clk, reset,
    output [31:0] WriteData, DataAdr,
    output MemWrite
);
    wire [31:0] PC, Instr, ReadData;

    // instantiate the processor and the memories
    single_cycle_processor riscv_s(clk, reset, PC, Instr, MemWrite, DataAdr, WriteData, ReadData);

    instr_memory imem(PC, Instr);
    data_memory dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule
