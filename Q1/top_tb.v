`include "top.v"

module testbench();
    reg clk;
    reg reset;
    wire [31:0] WriteData, DataAdr;
    wire MemWrite;

    // Device under test (DUT)
    top dut(clk, reset, WriteData, DataAdr, MemWrite);

    // Initial reset
    initial begin
        reset <= 1; #22; reset <= 0;
    end

    // Clock generation
    always begin
        clk <= 1; #5; clk <= 0; #5;
    end

    // Check results
    always @(negedge clk) begin
        // Display debug information
        $display("Clock: %b, Reset: %b, DataAdr: %h, WriteData: %h, MemWrite: %b", clk, reset, DataAdr, WriteData, MemWrite);

        // Check for memory write operation
        if (MemWrite) begin
            if ((DataAdr === 100) & (WriteData === 25)) begin
                $display("Simulation succeeded");
                $stop;
            end else if (DataAdr !== 96) begin 
                $display("Simulation failed");
                $stop;
            end
        end
    end

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, testbench);
    end
endmodule

// iverilog -o top_tb.vvp top_tb.v
// vvp top_tb.vvp