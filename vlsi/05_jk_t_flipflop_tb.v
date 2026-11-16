`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : jk_t_ff_tb
// Project     : Testbench: JK flip-flop and T flip-flop
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// Testbench: JK flip-flop and T flip-flop
module jk_t_ff_tb;
    reg  clk, rst, j, k, t;
    wire q_jk, qbar_jk, q_t, qbar_t;

    jk_ff uut_jk (.clk(clk), .rst(rst), .j(j), .k(k), .q(q_jk), .qbar(qbar_jk));
    t_ff  uut_t  (.clk(clk), .rst(rst), .t(t),        .q(q_t),  .qbar(qbar_t));

    always #5 clk = ~clk;          // 10 ns clock

    initial begin
        $monitor("t=%0t rst=%b | J=%b K=%b Q=%b | T=%b Q=%b", $time, rst, j, k, q_jk, t, q_t);

        clk = 0; rst = 1; j = 0; k = 0; t = 0;
        #10 rst = 0;
        // JK tests
        j = 1; k = 0; #10;   // set
        j = 0; k = 0; #10;   // hold
        j = 0; k = 1; #10;   // reset
        j = 1; k = 1; #20;   // toggle twice
        // T tests
        t = 1; #30;          // toggle 3 times
        t = 0; #20;          // hold
        $finish;
    end
endmodule
