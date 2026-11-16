`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : mux4to1_tb
// Project     : Testbench: 4:1 Multiplexer
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// Testbench: 4:1 Multiplexer
module mux4to1_tb;
    reg  [3:0] i;
    reg  [1:0] s;
    wire       y;

    mux4to1 uut (.i(i), .s(s), .y(y));

    initial begin
        $monitor("t=%0t  i=%b  s=%b  y=%b", $time, i, s, y);

        i = 4'b1010;
        s = 2'b00; #10;
        s = 2'b01; #10;
        s = 2'b10; #10;
        s = 2'b11; #10;
        i = 4'b0101;
        s = 2'b00; #10;
        s = 2'b01; #10;
        s = 2'b10; #10;
        s = 2'b11; #10;
        $finish;
    end
endmodule
