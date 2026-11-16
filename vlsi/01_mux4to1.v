`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : mux4to1
// Project     : Practical 1: 4:1 Multiplexer
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// Practical 1: 4:1 Multiplexer
// y = i[s]  (s = 00 -> i0, 01 -> i1, 10 -> i2, 11 -> i3)
module mux4to1 (
    input  [3:0] i,     // data inputs i3 i2 i1 i0
    input  [1:0] s,     // select lines s1 s0
    output reg   y
);
    always @(*) begin
        case (s)
            2'b00: y = i[0];
            2'b01: y = i[1];
            2'b10: y = i[2];
            2'b11: y = i[3];
            default: y = 1'b0;
        endcase
    end
endmodule

// Dataflow version (write this if asked for dataflow modelling):
// assign y = (~s[1] & ~s[0] & i[0]) | (~s[1] & s[0] & i[1]) |
//            ( s[1] & ~s[0] & i[2]) | ( s[1] & s[0] & i[3]);
