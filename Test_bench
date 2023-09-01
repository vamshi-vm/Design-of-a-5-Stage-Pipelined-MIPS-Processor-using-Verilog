`timescale 1ns / 1ns
module test_Toppipe32;
    reg clk;
    //------------for IF
    wire [11:0]IF_stage_NPC;
    wire [31:0]IF_stage_IR;
    wire [11:0]IF_reg_NPC;
    wire [31:0]IF_reg_IR;
    //-----------for ID
    wire [4:0]ID_reg_rd1;
    wire [4:0]ID_reg_rd0;
    wire [31:0]ID_reg_SImm;
    wire [31:0]ID_reg_B;
    wire [31:0]ID_reg_A;
    wire [11:0]ID_reg_NPC;
    wire [8:0]ID_reg_control;
    //------------for EXE
    wire [4:0]EX_reg_rd;
    wire [31:0]EX_reg_B,EX_stage_ALUop;
    wire EX_reg_zero;
    wire [11:0]EX_reg_NPC;
    wire [1:0]EX_reg_WB;
    wire [2:0]EX_reg_MEM;
    //-----------for MEM
    wire [4:0]MEM_reg_rd;
    wire [31:0]MEM_reg_ALUOUT;
    wire [31:0]MEM_reg_readdata;
    wire [1:0]MEM_reg_WB;
    //------------ for WB
    wire RegWrite_cond;
    wire [31:0]Write_data;
    wire [4:0]Write_reg_addr;
    //-------------
    initial clk=1'b1;
    always #4 clk=~clk;
    Top_pipe32 DUT(clk);
    //-----------for IF
    assign IF_stage_NPC=Top_pipe32.NPC;
    assign IF_stage_IR=Top_pipe32.IF_IR;
    assign IF_reg_NPC=Top_pipe32.IF_ID[43:32];
    assign IF_reg_IR=Top_pipe32.IF_ID[31:0];
    //------------for ID
    assign ID_reg_rd1 = Top_pipe32.ID_EX[4:0];
    assign ID_reg_rd0 = Top_pipe32.ID_EX[9:5];
    assign ID_reg_SImm = Top_pipe32.ID_EX[41:10];
    assign ID_reg_B = Top_pipe32.ID_EX[73:42];
    assign ID_reg_A = Top_pipe32.ID_EX[105:74];
    assign ID_reg_NPC = Top_pipe32.ID_EX[117:106];
    assign ID_reg_control = Top_pipe32.ID_EX[126:118];
    //--------------- for EXE
    assign EX_reg_rd = Top_pipe32.EX_MEM[4:0];
    assign EX_reg_B = Top_pipe32.EX_MEM[36:5];
    assign EX_stage_ALUop = Top_pipe32.EX_MEM[68:37];
    assign EX_reg_zero = Top_pipe32.EX_MEM[69];
    assign EX_reg_NPC = Top_pipe32.EX_MEM[81:70];
    assign EX_reg_WB = Top_pipe32.EX_MEM[83:82];
    assign EX_reg_MEM = Top_pipe32.EX_MEM[86:84];
    //--------------- for MEM
    assign MEM_reg_rd = Top_pipe32.MEM_WB[4:0];
    assign MEM_reg_ALUOUT = Top_pipe32.MEM_WB[36:5];
    assign MEM_reg_readdata = Top_pipe32.MEM_WB[68:37];
    assign MEM_reg_WB = Top_pipe32.MEM_WB[70:69];
    //---------------- for WB
    assign RegWrite_cond = Top_pipe32.RegWrite_cond;
    assign Write_data = Top_pipe32.Write_data;
    assign Write_reg_addr = Top_pipe32.Write_reg_addr;
endmodule
