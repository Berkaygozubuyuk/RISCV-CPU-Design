 module alu(
     input  wire [31:0] A, B,
     input  wire [2:0]   ALUControl,
     output reg  [31:0] Result,
     output        Zero
 );

     always @(*) begin
         case(ALUControl)
             3'b000: Result = A + B;                 // ADD
             3'b001: Result = A - B;                 // SUB
             3'b010: Result = A & B;                 // AND
             3'b011: Result = A | B;                 // OR
             3'b101: Result = ($signed(A) < $signed(B)) ? 1 : 0; // SLT
             3'b100: Result = A << B[4:0];           // **SLL**
             default: Result = 0;
         endcase
     end

     assign Zero = (Result == 0);

 endmodule
