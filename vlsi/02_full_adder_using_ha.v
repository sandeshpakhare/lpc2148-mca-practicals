`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : full_adder (uses half_adder)
// Project     : Practical 2: Full adder using two half adders
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// Practical 2: Full adder using two half adders
// sum = a ^ b ^ cin,  cout = a&b | cin&(a^b)

module half_adder (
    input  a, b,
    output sum, carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule

module full_adder (
    input  a, b, cin,
    output sum, cout
);
    wire s1, c1, c2;

    half_adder ha1 (.a(a),  .b(b),   .sum(s1),  .carry(c1));   // a + b
    half_adder ha2 (.a(s1), .b(cin), .sum(sum), .carry(c2));   // (a^b) + cin
    assign cout = c1 | c2;
endmodule
