// Testbench: 4-bit ALU
`timescale 1ns/1ps
module alu_4bit_tb;
    reg  [3:0] a, b;
    reg  [2:0] sel;
    wire [3:0] y;
    wire       cout;
    integer k;

    alu_4bit uut (.a(a), .b(b), .sel(sel), .y(y), .cout(cout));

    initial begin
        $dumpfile("alu_4bit.vcd");
        $dumpvars(0, alu_4bit_tb);
        a = 4'b1011;   // 11
        b = 4'b0110;   // 6
        for (k = 0; k < 8; k = k + 1) begin
            sel = k;
            #10;
            $display("sel=%b  a=%b  b=%b  ->  y=%b  cout=%b", sel, a, b, y, cout);
        end
        $finish;
    end
endmodule
