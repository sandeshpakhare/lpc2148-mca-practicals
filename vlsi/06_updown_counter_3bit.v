`timescale 1ns/1ps
// Practical 6: 3-bit synchronous up/down counter
// up_down = 1 -> count up 0..7,  up_down = 0 -> count down 7..0
module updown_counter (
    input            clk, rst, up_down,
    output reg [2:0] count
);
    always @(posedge clk) begin
        if (rst)
            count <= 3'b000;
        else if (up_down)
            count <= count + 1'b1;
        else
            count <= count - 1'b1;
    end
endmodule
