`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : jk_ff, t_ff
// Project     : JK Flip-Flop and T Flip-Flop
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// JK: 00 no change, 01 reset, 10 set, 11 toggle
module jk_ff (clk, rst, J, K, Q, Qbar);
    input clk, rst, J, K;
    output reg Q;
    output Qbar;

    assign Qbar = ~Q;

    always @(posedge clk)
    begin
        if (rst == 1)
            Q <= 0;
        else if (J == 0 && K == 0)
            Q <= Q;        // no change
        else if (J == 0 && K == 1)
            Q <= 0;        // reset
        else if (J == 1 && K == 0)
            Q <= 1;        // set
        else
            Q <= ~Q;       // toggle
    end
endmodule

// T: 0 no change, 1 toggle
module t_ff (clk, rst, T, Q, Qbar);
    input clk, rst, T;
    output reg Q;
    output Qbar;

    assign Qbar = ~Q;

    always @(posedge clk)
    begin
        if (rst == 1)
            Q <= 0;
        else if (T == 1)
            Q <= ~Q;       // toggle
        else
            Q <= Q;        // no change
    end
endmodule
