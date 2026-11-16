// Testbench: 4-bit SISO shift register (shifts in 1011)
`timescale 1ns/1ps
module siso_tb;
    reg  clk, rst, sin;
    wire sout;

    siso uut (.clk(clk), .rst(rst), .sin(sin), .sout(sout));

    always #5 clk = ~clk;          // 10 ns clock

    initial begin
        $dumpfile("siso.vcd");
        $dumpvars(0, siso_tb);
        $monitor("t=%0t rst=%b sin=%b q=%b sout=%b", $time, rst, sin, uut.q, sout);

        clk = 0; rst = 1; sin = 0;
        #10 rst = 0;
        sin = 1; #10;
        sin = 0; #10;
        sin = 1; #10;
        sin = 1; #10;
        sin = 0; #40;     // flush: 1011 comes out at sout
        $finish;
    end
endmodule
