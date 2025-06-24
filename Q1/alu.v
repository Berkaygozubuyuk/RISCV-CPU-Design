module alu(
  input [31:0] a, b, 
  input [2:0] alucont, 
  output reg [31:0] result,
  output zero
);

  always @(*)
    case(alucont[2:0])
      3'b000: result <= a + b;   // Add
      3'b001: result <= a - b;   // Subtract
      3'b010: result <= a & b;   // AND
      3'b011: result <= a | b;   // OR
      3'b101: result <= $signed(a) < $signed(b) ? 1 : 0;  // SLT
    endcase

  assign zero = (result == 32'b0);
endmodule
