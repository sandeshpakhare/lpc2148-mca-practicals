`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : bin_to_gray
// Project     : Binary to Gray Code Converter
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// G3 = B3, G2 = B3^B2, G1 = B2^B1, G0 = B1^B0
module bin_to_gray (B, G);
    input [3:0] B;
    output [3:0] G;

    assign G[3] = B[3];
    assign G[2] = B[3] ^ B[2];
    assign G[1] = B[2] ^ B[1];
    assign G[0] = B[1] ^ B[0];
endmodule
