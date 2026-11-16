`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : siso
// Project     : Practical 7: 4-bit Serial In Serial Out (SISO) shift register
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// Practical 7: 4-bit Serial In Serial Out (SISO) shift register
// Each clock: data shifts one place; serial input appears at output after 4 clocks
module siso (
    input      clk, rst, sin,
    output     sout
);
    reg [3:0] q;

    always @(posedge clk) begin
        if (rst)
            q <= 4'b0000;
        else
            q <= {q[2:0], sin};    // shift left, new bit enters at q[0]
    end

    assign sout = q[3];
endmodule
