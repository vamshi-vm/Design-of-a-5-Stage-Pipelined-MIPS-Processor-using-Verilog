`timescale 1ns / 1ns
module IF_stage(clk,IR,NPC);
    input clk;
    output reg [31:0]IR;
    output wire [11:0] NPC;
    reg [31:0]instruction_bus;
    reg [11:0]instruction_pointer;
    wire PCSrc;
    wire [11:0]EX_MEM_ALUOut;
    reg [7:0]instruction_memory[0:4095]; //32*1024 Instruction memory
    reg [11:0] PC;
    wire [11:0]MUX_op;
    reg [11:0]PC_add;
    wire [11:0]PC_op;
    initial PC=12'h000;
    initial instruction_pointer=12'h000;
    assign PC_op = PC;
    assign NPC=PC_add;
    always@(posedge clk)
        begin
            #1;
            PC_add=PC_op+12'h004;
            IR= {instruction_memory[PC_op+3], instruction_memory[PC_op+2], instruction_memory[PC_op+1], instruction_memory[PC_op]};
        end
    mux2to1 MUX(.out(MUX_op),.in1(EX_MEM_ALUOut),.in0(PC_add),.sel(PCSrc)); 
    always@(MUX_op)
        PC=MUX_op;
    always@(*)
        begin
            instruction_memory[instruction_pointer]  =instruction_bus[7:0];
            instruction_memory[instruction_pointer+1]=instruction_bus[15:8];
            instruction_memory[instruction_pointer+2]=instruction_bus[23:16];
            instruction_memory[instruction_pointer+3]=instruction_bus[31:24];
            instruction_pointer=instruction_pointer+4;
        end
        initial
            begin
                      instruction_bus=32'b11111100000000011111100000000000;
                   #1 instruction_bus=32'b11111100110011011111000000000001;
                   #1 instruction_bus=32'b11111100011001011110100000000010;
                   #1 instruction_bus=32'b11111101010011101110000000000011;
                   #1 instruction_bus=32'b11111110000000101101100000000101;
                   #1 instruction_bus=32'b10101100000111110000000001100100;	
                   #1 instruction_bus=32'b10101100000111100000000010011110;
                   #1 instruction_bus=32'b00001100010110100011111111111111;
                   #1 instruction_bus=32'b00001100100110010000001000000000;
                   #1 instruction_bus=32'b10001100000110000000000001100100;
                   #1 instruction_bus=32'b10001100000101110000000010011110;
            end
endmodule
