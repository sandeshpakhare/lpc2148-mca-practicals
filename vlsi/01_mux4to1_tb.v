`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : mux4_1_tb
// Project     : Testbench: 4:1 Multiplexer
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

module mux4_1_tb;
    reg w0, w1, w2, w3;
    reg [1:0] S;
    wire f;

    mux4_1 uut (.w0(w0), .w1(w1), .w2(w2), .w3(w3), .S(S), .f(f));

    initial
    begin
        $monitor("t=%0t  w3=%b w2=%b w1=%b w0=%b  S=%b  f=%b", $time, w3, w2, w1, w0, S, f);

        w0 = 0; w1 = 1; w2 = 0; w3 = 1;
        S = 2'b00; #10;
        S = 2'b01; #10;
        S = 2'b10; #10;
        S = 2'b11; #10;

        w0 = 1; w1 = 0; w2 = 1; w3 = 0;
        S = 2'b00; #10;
        S = 2'b01; #10;
        S = 2'b10; #10;
        S = 2'b11; #10;
        $finish;
    end
endmodule
