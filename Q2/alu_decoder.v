 module alu_decoder(
     input  wire [1:0] ALUOp,
     input  wire [2:0] funct3,
     input  wire       funct7,
     input  wire [6:0] op,
     output reg  [2:0] ALUControl
 );

     always @(*) begin
         case(ALUOp)
             2'b00: ALUControl = 3'b000; // add (lw/sw)
             2'b01: ALUControl = 3'b001; // sub (beq)
             2'b10: // R-type
                 case ({funct7, funct3})
                     4'b0_000: ALUControl = 3'b000; // add
                     4'b1_000: ALUControl = 3'b001; // sub
                     4'b?_010: ALUControl = 3'b101; // slt
                     4'b?_110: ALUControl = 3'b011; // or
                     4'b?_111: ALUControl = 3'b010; // and
                     4'b0_001: ALUControl = 3'b100; // **sll**
                     default:  ALUControl = 3'b000;
                 endcase

             default: ALUControl = 3'b000;
         endcase
     end

 endmodule
