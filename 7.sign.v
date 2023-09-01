`timescale 1ns / 1ps
module sign(Y,A);
    input [15:0]A;
    output wire [31:0]Y;
    assign Y={ {16{A[15]}},A[15:0] };
endmodule
