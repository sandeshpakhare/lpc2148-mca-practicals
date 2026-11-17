`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : alu_4bit_tb
// Project     : Testbench: 4-bit ALU
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

module alu_4bit_tb;
    reg [3:0] A, B;
    reg [2:0] S;
    wire [3:0] Y;
    wire cout;

    alu_4bit uut (A, B, S, Y, cout);

    initial
    begin
        $monitor("t=%0t  A=%b B=%b S=%b  Y=%b cout=%b", $time, A, B, S, Y, cout);
        A = 4'b1011; B = 4'b0110;     // A = 11, B = 6
        S = 3'b000; #10;   // add
        S = 3'b001; #10;   // sub
        S = 3'b010; #10;   // AND
        S = 3'b011; #10;   // OR
        S = 3'b100; #10;   // XOR
        S = 3'b101; #10;   // NOT A
        S = 3'b110; #10;   // shift left
        S = 3'b111; #10;   // shift right
        $finish;
    end
endmodule
