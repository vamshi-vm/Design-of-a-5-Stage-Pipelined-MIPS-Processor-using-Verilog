`timescale 1ns / 1ns
module WB_stage(Write_data,Write_reg,RegWrite,MEM_WB);
    input [70:0]MEM_WB;
    output reg [31:0]Write_data;
    output wire [4:0]Write_reg;
    output wire RegWrite;
    wire [1:0]contWB;
    wire [31:0]data_from_mem,data_from_ALU;
    wire [4:0]destination_addr;
    wire Memtoreg;
    //--------
    assign destination_addr = MEM_WB[4:0];
    assign data_from_ALU = MEM_WB[36:5];
    assign data_from_mem = MEM_WB[68:37];
    assign contWB = MEM_WB[70:69];
    assign RegWrite = contWB[1];
    assign Memtoreg = contWB[0];
    assign Write_reg = destination_addr;     
    always@(*)
        if(Memtoreg == 1)
            Write_data = data_from_mem;
        else if(Memtoreg == 0)
            Write_data = data_from_ALU ;
endmodule
