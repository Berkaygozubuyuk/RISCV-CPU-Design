module instr_memory(
    input [31:0] a,
    output [31:0] rd
);
    reg [31:0] RAM[63:0];
    
    initial begin
      $readmemh("riscvtest.v",RAM);
    end

  assign rd = RAM[a[31:2]]; // word aligned
endmodule