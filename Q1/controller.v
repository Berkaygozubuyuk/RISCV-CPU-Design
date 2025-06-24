`include "main_decoder.v"
`include "alu_decoder.v"

module controller(op, funct3, funct7, Zero, PCSrc, Jump, ResultSrc, MemWrite, ALUControl, ALUSrc, ImmSrc, RegWrite);
    input [6:0] op;
    input [2:0] funct3;
    input funct7, Zero;
    output PCSrc, Jump, MemWrite, ALUSrc, RegWrite;
    output [1:0] ResultSrc, ImmSrc;
    output [2:0] ALUControl;

    wire [1:0] ALUOp;
    wire Branch;

    main_decoder md(op, ResultSrc, MemWrite, Branch, ALUSrc, RegWrite, Jump, ImmSrc, ALUOp);
    alu_decoder ad(ALUOp, funct3, funct7, op, ALUControl);
    
    assign PCSrc = (Branch & Zero) | Jump;
endmodule
