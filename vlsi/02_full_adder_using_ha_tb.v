// Testbench: Full adder using two half adders (all 8 combinations)
`timescale 1ns/1ps
module full_adder_tb;
    reg  a, b, cin;
    wire sum, cout;
    integer k;

    full_adder uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        $dumpfile("full_adder.vcd");
        $dumpvars(0, full_adder_tb);
        $display(" a b cin | sum cout");
        for (k = 0; k < 8; k = k + 1) begin
            {a, b, cin} = k;
            #10;
            $display(" %b %b  %b  |  %b   %b", a, b, cin, sum, cout);
        end
        $finish;
    end
endmodule
