`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : Sandesh Pakhare
// Module Name : jk_ff, t_ff
// Project     : Practical 5: JK flip-flop and T flip-flop (positive edge, synchronous reset)
// Tool        : Xilinx Vivado (behavioral simulation)
//////////////////////////////////////////////////////////////////////////////////

// Practical 5: JK flip-flop and T flip-flop (positive edge, synchronous reset)

// JK: 00 hold, 01 reset, 10 set, 11 toggle
module jk_ff (
    input      clk, rst, j, k,
    output reg q,
    output     qbar
);
    assign qbar = ~q;
    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;
        else
            case ({j, k})
                2'b00: q <= q;      // no change
                2'b01: q <= 1'b0;   // reset
                2'b10: q <= 1'b1;   // set
                2'b11: q <= ~q;     // toggle
            endcase
    end
endmodule

// T: 0 hold, 1 toggle
module t_ff (
    input      clk, rst, t,
    output reg q,
    output     qbar
);
    assign qbar = ~q;
    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;
        else if (t)
            q <= ~q;        // toggle
        else
            q <= q;         // no change
    end
endmodule
