`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : jk_t_ff_tb
// Project     : Testbench: JK Flip-Flop and T Flip-Flop
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

module jk_t_ff_tb;
    reg clk, rst, J, K, T;
    wire Q_jk, Qbar_jk, Q_t, Qbar_t;

    jk_ff uut1 (clk, rst, J, K, Q_jk, Qbar_jk);
    t_ff  uut2 (clk, rst, T, Q_t, Qbar_t);

    always #5 clk = ~clk;      // clock period 10 ns

    initial
    begin
        $monitor("t=%0t rst=%b | J=%b K=%b Q=%b | T=%b Q=%b", $time, rst, J, K, Q_jk, T, Q_t);
        clk = 0; rst = 1; J = 0; K = 0; T = 0;
        #10 rst = 0;
        J = 1; K = 0; #10;     // set
        J = 0; K = 0; #10;     // no change
        J = 0; K = 1; #10;     // reset
        J = 1; K = 1; #20;     // toggle
        T = 1; #30;            // T toggles
        T = 0; #20;            // T no change
        $finish;
    end
endmodule
