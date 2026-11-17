`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : siso
// Project     : 4-bit Serial In Serial Out Shift Register
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// Data entered at din comes out at dout after 4 clock pulses
module siso (clk, rst, din, dout);
    input clk, rst, din;
    output dout;
    reg [3:0] q;

    always @(posedge clk)
    begin
        if (rst == 1)
            q <= 4'b0000;
        else
        begin
            q[3] <= q[2];
            q[2] <= q[1];
            q[1] <= q[0];
            q[0] <= din;
        end
    end

    assign dout = q[3];
endmodule
