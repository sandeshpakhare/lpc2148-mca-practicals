`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : siso_tb
// Project     : Testbench: 4-bit Serial In Serial Out Shift Register
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

module siso_tb;
    reg clk, rst, din;
    wire dout;

    siso uut (clk, rst, din, dout);

    always #5 clk = ~clk;      // clock period 10 ns

    initial
    begin
        $monitor("t=%0t rst=%b din=%b q=%b dout=%b", $time, rst, din, uut.q, dout);
        clk = 0; rst = 1; din = 0;
        #10 rst = 0;
        din = 1; #10;          // serial data 1 0 1 1
        din = 0; #10;
        din = 1; #10;
        din = 1; #10;
        din = 0; #40;          // data comes out at dout
        $finish;
    end
endmodule
