`timescale 1ns / 1ns
module mux2to1(out,in1,in0,sel);
    input [11:0]in0;
    input [11:0]in1;
    input sel;
    output reg [11:0]out;
    always@(*)
        begin
            if(sel == 1)
                out <= in1;
            else
                out <= in0;
        end  
endmodule
