// LUI CPU Design for Icarus Verilog
// Modules: ImmGen, Control, ALUControl, RegisterFile, ALU, CPU (top-level datapath), and testbench

// 1) Immediate Generator
module ImmGen(
    input  wire [31:0] instr,
    output reg  [31:0] imm32
);
    always @(*) begin
        case (instr[6:0])
            7'b0110111: // LUI
                imm32 = {instr[31:12], 12'b0};
            default: // other formats not supported here
                imm32 = 32'b0;
        endcase
    end
endmodule

// 2) Control Unit
module Control(
    input  wire [6:0] opcode,
    output wire       RegWrite,
    output wire       MemRead,
    output wire       MemWrite,
    output wire       MemToReg,
    output wire       ALUSrc,
    output wire [1:0] ALUOp
);
    wire is_LUI;
    assign is_LUI    = (opcode == 7'b0110111);
    // R-type, I-type etc. omitted except LUI
    assign RegWrite  = is_LUI;
    assign MemRead   = 1'b0;
    assign MemWrite  = 1'b0;
    assign MemToReg  = 1'b0;  // write immediate
    assign ALUSrc    = is_LUI;
    assign ALUOp     = is_LUI ? 2'b01 : 2'b00;
endmodule

// 3) ALU Control
module ALUControl(
    input  wire [1:0] ALUOp,
    input  wire [2:0] funct3,
    output reg  [3:0] ALUctr
);
    always @(*) begin
        case (ALUOp)
            2'b01: // PASS IMM for LUI
                ALUctr = 4'b1010; // custom code
            default:
                ALUctr = 4'b0000; // NOP
        endcase
    end
endmodule

// 4) Register File (32x32)
module RegisterFile(
    input  wire        clk,
    input  wire        we,
    input  wire [4:0]  ra1, ra2, wa,
    input  wire [31:0] wd,
    output reg  [31:0] rd1, rd2
);
    reg [31:0] regs [31:0];
    integer i;
    initial for (i = 0; i < 32; i = i + 1) regs[i] = 32'b0;
    always @(*) begin
        rd1 = regs[ra1];
        rd2 = regs[ra2];
    end
    always @(posedge clk) begin
        if (we && wa != 0)
            regs[wa] <= wd;
    end
endmodule

// 5) ALU (supports PASS IMM)
module ALU(
    input  wire [31:0] A,
    input  wire [31:0] B,
    input  wire [3:0]  ALUctr,
    output reg  [31:0] Result
);
    always @(*) begin
        case (ALUctr)
            4'b1010: Result = B; // PASS IMM
            default: Result = 32'b0;
        endcase
    end
endmodule

// 6) Top-level CPU datapath
module CPU(
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] instr,
    output wire [31:0] rd_out
);
    wire [31:0] imm;
    wire        RegWrite;
    wire        MemRead, MemWrite, MemToReg, ALUSrc;
    wire [1:0]  ALUOp;
    wire [3:0]  ALUctr;
    wire [31:0] rd1, rd2, alu_b, alu_out, wb_data;

    // Instantiate modules
    ImmGen     immgen(.instr(instr), .imm32(imm));
    Control    ctrl(.opcode(instr[6:0]), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .MemToReg(MemToReg), .ALUSrc(ALUSrc), .ALUOp(ALUOp));
    ALUControl aluctrl(.ALUOp(ALUOp), .funct3(instr[14:12]), .ALUctr(ALUctr));
    RegisterFile rf(.clk(clk), .we(RegWrite), .ra1(instr[19:15]), .ra2(instr[24:20]), .wa(instr[11:7]), .wd(wb_data), .rd1(rd1), .rd2(rd2));
    ALU        alu(.A(32'b0), .B(ALUSrc ? imm : rd2), .ALUctr(ALUctr), .Result(alu_out));

    // Writeback mux
    assign wb_data = alu_out;
    assign rd_out  = rf.regs[instr[11:7]]; // for observation
endmodule