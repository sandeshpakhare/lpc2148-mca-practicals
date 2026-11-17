`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : up_down_counter_tb
// Project     : Testbench: 3-bit Synchronous Up/Down Counter
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

module up_down_counter_tb;
    reg clk, rst, up_down;
    wire [2:0] count;

    up_down_counter uut (clk, rst, up_down, count);

    always #5 clk = ~clk;      // clock period 10 ns

    initial
    begin
        $monitor("t=%0t rst=%b up_down=%b count=%b (%0d)", $time, rst, up_down, count, count);
        clk = 0; rst = 1; up_down = 1;
        #10 rst = 0;
        #80;                   // count up
        up_down = 0;
        #80;                   // count down
        $finish;
    end
endmodule
