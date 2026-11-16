`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : updown_counter_tb
// Project     : Testbench: 3-bit synchronous up/down counter
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// Testbench: 3-bit synchronous up/down counter
module updown_counter_tb;
    reg        clk, rst, up_down;
    wire [2:0] count;

    updown_counter uut (.clk(clk), .rst(rst), .up_down(up_down), .count(count));

    always #5 clk = ~clk;          // 10 ns clock

    initial begin
        $monitor("t=%0t rst=%b up_down=%b count=%d (%b)", $time, rst, up_down, count, count);

        clk = 0; rst = 1; up_down = 1;
        #10 rst = 0;
        #80;              // count up 8 clocks: 1..7, 0
        up_down = 0;
        #80;              // count down 8 clocks
        $finish;
    end
endmodule
