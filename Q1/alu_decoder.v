module alu_decoder(ALUOp, funct3, funct7, op, ALUControl);
    input funct7;
    input [1:0] ALUOp;
    input [2:0] funct3;
    input [6:0] op;
    output [2:0] ALUControl;

    assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :     // addition
                        (ALUOp == 2'b01) ? 3'b001 :     // subtraction
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7} == 2'b11)) ? 3'b001 :  // sub
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7} != 2'b11)) ? 3'b000 :  // add, addi
                        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 : // slt, slti
                        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 : // or, ori
                        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : // and, andi
                                                                  3'b000 ;
endmodule