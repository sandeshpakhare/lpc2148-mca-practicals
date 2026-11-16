// Testbench: Binary to Gray converter (all 16 inputs)
`timescale 1ns/1ps
module bin2gray_tb;
    reg  [3:0] b;
    wire [3:0] g;
    integer k;

    bin2gray uut (.b(b), .g(g));

    initial begin
        $dumpfile("bin2gray.vcd");
        $dumpvars(0, bin2gray_tb);
        $display("Binary | Gray");
        for (k = 0; k < 16; k = k + 1) begin
            b = k;
            #10;
            $display(" %b  | %b", b, g);
        end
        $finish;
    end
endmodule
