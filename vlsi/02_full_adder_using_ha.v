`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : full_adder (uses half_adder)
// Project     : Full Adder using two Half Adders
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

module half_adder (a, b, s, c);
    input a, b;
    output s, c;

    assign s = a ^ b;
    assign c = a & b;
endmodule

module full_adder (a, b, cin, sum, cout);
    input a, b, cin;
    output sum, cout;
    wire s1, c1, c2;

    half_adder HA1 (a, b, s1, c1);       // first half adder : a + b
    half_adder HA2 (s1, cin, sum, c2);   // second half adder: s1 + cin
    assign cout = c1 | c2;
endmodule
