`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : full_adder_tb
// Project     : Testbench: Full Adder using two Half Adders
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

module full_adder_tb;
    reg a, b, cin;
    wire sum, cout;

    full_adder uut (a, b, cin, sum, cout);

    initial
    begin
        $monitor("t=%0t  a=%b b=%b cin=%b  sum=%b cout=%b", $time, a, b, cin, sum, cout);
        a = 0; b = 0; cin = 0; #10;
        a = 0; b = 0; cin = 1; #10;
        a = 0; b = 1; cin = 0; #10;
        a = 0; b = 1; cin = 1; #10;
        a = 1; b = 0; cin = 0; #10;
        a = 1; b = 0; cin = 1; #10;
        a = 1; b = 1; cin = 0; #10;
        a = 1; b = 1; cin = 1; #10;
        $finish;
    end
endmodule
