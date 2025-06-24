module main_decoder(
    input [6:0] op,
    output [1:0] ResultSrc,
    output MemWrite,
    output Branch,
    output ALUSrc,
    output RegWrite,
    output Jump,
    output [1:0] ImmSrc,
    output [1:0] ALUOp
);
    reg [10:0] controls;
    assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump} = controls;

    always @(*)
        case(op)
            7'b0000011: controls = 11'b10010010000;  // lw
            7'b0100011: controls = 11'b00111xx0000;  // sw
            7'b0110011: controls = 11'b1xx00000100;  // R-type
            7'b1100011: controls = 11'b01000xx1010;  // beq
            7'b0010011: controls = 11'b10010000100;  // I-type ALU
            7'b1101111: controls = 11'b111x0100xx1;  // jal
            default:    controls = 11'bxxxxxxxxxxx;
        endcase

endmodule
