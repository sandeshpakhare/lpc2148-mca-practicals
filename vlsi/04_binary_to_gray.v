`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : bin2gray
// Project     : Practical 4: 4-bit Binary to Gray code converter
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// Practical 4: 4-bit Binary to Gray code converter
// g3 = b3, g2 = b3^b2, g1 = b2^b1, g0 = b1^b0
module bin2gray (
    input  [3:0] b,
    output [3:0] g
);
    assign g[3] = b[3];
    assign g[2] = b[3] ^ b[2];
    assign g[1] = b[2] ^ b[1];
    assign g[0] = b[1] ^ b[0];
    // short form: assign g = b ^ (b >> 1);
endmodule
