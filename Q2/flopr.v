// resetable flip-flop
module flopr #(parameter WIDTH = 8)(
    input clk, reset,
    input [WIDTH - 1:0] d,
    output reg [WIDTH - 1:0] q
);
    always @(posedge clk, posedge reset)
        if(reset)
            q <= 0;
        else
            q <= d;
endmodule

// resetable flip-flop with enable
module flopenr #(parameter WIDTH = 8)(
    input clk, reset, en,
    input [WIDTH - 1:0] d,
    output reg [WIDTH - 1:0] q
);
    always @(posedge clk, posedge reset)
        if(reset)
            q <= 0;
        else if(en)
            q <= d;
endmodule