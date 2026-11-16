`timescale 1ns/1ps
// Practical 3: 4-bit ALU
// sel | operation
// 000 | a + b   (cout = carry)
// 001 | a - b   (cout = borrow)
// 010 | a & b
// 011 | a | b
// 100 | a ^ b
// 101 | ~a
// 110 | a << 1
// 111 | a >> 1
module alu_4bit (
    input      [3:0] a, b,
    input      [2:0] sel,
    output reg [3:0] y,
    output reg       cout
);
    always @(*) begin
        cout = 1'b0;
        case (sel)
            3'b000: {cout, y} = a + b;
            3'b001: {cout, y} = a - b;
            3'b010: y = a & b;
            3'b011: y = a | b;
            3'b100: y = a ^ b;
            3'b101: y = ~a;
            3'b110: y = a << 1;
            3'b111: y = a >> 1;
            default: y = 4'b0000;
        endcase
    end
endmodule
