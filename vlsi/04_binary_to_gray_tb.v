`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : bin2gray_tb
// Project     : Testbench: Binary to Gray converter (all 16 inputs)
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// Testbench: Binary to Gray converter (all 16 inputs)
module bin2gray_tb;
    reg  [3:0] b;
    wire [3:0] g;
    integer k;

    bin2gray uut (.b(b), .g(g));

    initial begin
        $display("Binary | Gray");
        for (k = 0; k < 16; k = k + 1) begin
            b = k;
            #10;
            $display(" %b  | %b", b, g);
        end
        $finish;
    end
endmodule
