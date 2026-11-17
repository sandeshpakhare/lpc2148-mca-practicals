`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : mux4_1
// Project     : 4:1 Multiplexer
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

module mux4_1 (w0, w1, w2, w3, S, f);
    input w0, w1, w2, w3;
    input [1:0] S;
    output reg f;

    always @(*)
    begin
        if (S == 2'b00)
            f = w0;
        else if (S == 2'b01)
            f = w1;
        else if (S == 2'b10)
            f = w2;
        else
            f = w3;
    end
endmodule
