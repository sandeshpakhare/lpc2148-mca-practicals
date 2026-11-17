`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : bin_to_gray_tb
// Project     : Testbench: Binary to Gray Code Converter
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

module bin_to_gray_tb;
    reg [3:0] B;
    wire [3:0] G;
    integer i;

    bin_to_gray uut (B, G);

    initial
    begin
        $monitor("t=%0t  Binary=%b  Gray=%b", $time, B, G);
        for (i = 0; i < 16; i = i + 1)
        begin
            B = i; #10;
        end
        $finish;
    end
endmodule
