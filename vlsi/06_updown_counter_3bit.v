`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : up_down_counter
// Project     : 3-bit Synchronous Up/Down Counter
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// up_down = 1 : count up 0 to 7,  up_down = 0 : count down 7 to 0
module up_down_counter (clk, rst, up_down, count);
    input clk, rst, up_down;
    output reg [2:0] count;

    always @(posedge clk)
    begin
        if (rst == 1)
            count <= 3'b000;
        else if (up_down == 1)
            count <= count + 1;
        else
            count <= count - 1;
    end
endmodule
