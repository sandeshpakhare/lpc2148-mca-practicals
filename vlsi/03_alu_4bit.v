`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : alu_4bit
// Project     : 4-bit ALU
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// S = 000 add, 001 sub, 010 AND, 011 OR, 100 XOR, 101 NOT A, 110 shift left, 111 shift right
module alu_4bit (A, B, S, Y, cout);
    input [3:0] A, B;
    input [2:0] S;
    output reg [3:0] Y;
    output reg cout;

    always @(*)
    begin
        cout = 1'b0;
        if (S == 3'b000)
            {cout, Y} = A + B;
        else if (S == 3'b001)
            {cout, Y} = A - B;
        else if (S == 3'b010)
            Y = A & B;
        else if (S == 3'b011)
            Y = A | B;
        else if (S == 3'b100)
            Y = A ^ B;
        else if (S == 3'b101)
            Y = ~A;
        else if (S == 3'b110)
            Y = A << 1;
        else
            Y = A >> 1;
    end
endmodule
