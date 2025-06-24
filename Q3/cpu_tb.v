`timescale 1ns/1ps

module CPU_tb;
  // portlar yok; dahili DUT instantiate edilecek
  reg         clk;
  reg         rst;
  reg  [31:0] instr;
  wire [31:0] rd_out;

  // DUT
  CPU dut(
    .clk(clk),
    .rst(rst),
    .instr(instr),
    .rd_out(rd_out)
  );

  // Clock üretimi
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    // 1) VCD dump başlat
    $dumpfile("cpu_tb.vcd");
    $dumpvars(0, CPU_tb);

    // 2) Reset & stimulus
    rst   = 1;       #10;
    rst   = 0;       #10;
    instr = {20'hABCDE, 5'd5, 7'b0110111}; // LUI x5, 0xABCDE000
    #50;  // simülasyona yeterli süre tanı

    // 3) Test sonucu
    if (rd_out !== {20'hABCDE, 12'b0})
      $display(">>> LUI FAIL: rd_out = %h, expected %h", rd_out, {20'hABCDE,12'b0});
    else
      $display(">>> LUI PASS: rd_out = %h", rd_out);

    // 4) Dump’u kapat ve simülasyonu bitir
    $finish;
  end
endmodule
