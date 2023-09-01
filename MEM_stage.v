`timescale 1ns / 1ns
module MEM_stage(contWB,MEM_Read_data,MEM_ALUout,MEM_rd,PCSrc,EX_MEM);
    input [86:0]EX_MEM;
    wire [31:0]DMEM_write_data;
    wire Branch,MemWrite,MemRead;
    wire zero;
    wire [2:0]cont_MEM;
    output wire PCSrc;
    output wire [1:0]contWB;
    output reg [31:0]MEM_Read_data;
    output wire [31:0]MEM_ALUout;
    output wire [4:0]MEM_rd;
    wire Branch_cond;
    reg [31:0]Data_mem[0:16383]; //32x2^14 Data_memory
    assign MEM_rd          = EX_MEM[4:0];
    assign DMEM_write_data = EX_MEM[36:5];
    assign MEM_ALUout      = EX_MEM[68:37];
    assign zero            = EX_MEM[69];
    assign contWB          = EX_MEM[83:82];
    assign cont_MEM        = EX_MEM[86:84];
    assign Branch    = cont_MEM[2];
    assign MemRead   = cont_MEM[1];
    assign MemWrite  = cont_MEM[0];
    assign Branch_cond = zero & Branch;
    assign PCSrc     = Branch_cond;
    always@(*)
        begin
            if(MemWrite == 1)
                Data_mem[MEM_ALUout]=DMEM_write_data;
            else if(MemRead == 1)
                MEM_Read_data=Data_mem[MEM_ALUout];
        end
endmodule
