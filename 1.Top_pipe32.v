`timescale 1ns / 1ns
module Top_pipe32(clk);
    input clk;
    reg [43:0]IF_ID; // IF_ID pipeline register
    reg [126:0]ID_EX; // ID_EX pipeline register
    reg [86:0]EX_MEM; // EX_MEM pipeline register
    reg [70:0]MEM_WB; // MEM_WB pipeline register
    //--------------
    wire [31:0]IF_IR;
    wire [11:0]NPC;
    //------------
    wire [31:0]IF_ID_IR;
    wire [11:0]IF_ID_NPC;
    wire [31:0]a,b,sign_extended_Imm;
    wire [8:0]contr;
    wire [4:0]rd_dest0,rd_dest1;
    //-------------
    wire [126:0]ID_EX_ip;
    wire [2:0]EX_stage_MEM;
    wire [1:0]EX_stage_WB;
    wire [11:0]EX_stage_NPC;
    wire EX_stage_zero;
    wire [31:0]EX_stage_ALUop,EX_stage_B;
    wire [4:0]EX_stage_rd;
    //-------------
    wire [86:0]EX_MEM_ip;
    wire [1:0]MEM_stage_WB;
    wire [31:0]MEM_stage_readdata;
    wire [31:0]MEM_stage_ALUOUT;
    wire [4:0]MEM_stage_rd;
    wire PCSrc_MEM;
    //-------------
    wire [70:0]MEM_WB_ip;
    wire RegWrite_cond;
    wire [31:0]Write_data;
    wire [4:0]Write_reg_addr;
    //---------
    assign IF_ID_IR  = IF_ID[31:0];
    assign IF_ID_NPC =IF_ID[43:32];
    //-----------
    assign ID_EX_ip = ID_EX;
    //----------
    assign EX_MEM_ip = EX_MEM;
    //----------
    assign MEM_WB_ip = MEM_WB;
    //-----------
    IF_stage  S1(.clk(clk),.IR(IF_IR),.NPC(NPC));
    ID_stage  S2(.sign_Imm(sign_extended_Imm),.A(a),.B(b),.rd0(rd_dest0),
                .rd1(rd_dest1),.control_bits(contr),.IF_ID_IR(IF_ID_IR),.IF_ID_NPC(IF_ID_NPC));
    EX_stage  S3(.cont_MEM(EX_stage_MEM),.cont_WB(EX_stage_WB),.NPC_ADD(EX_stage_NPC),.ZERO(EX_stage_zero),
                .ALU_result(EX_stage_ALUop),.EX_B(EX_stage_B),.EX_rd(EX_stage_rd),.ID_EX(ID_EX_ip));
    MEM_stage S4(.contWB(MEM_stage_WB),.MEM_Read_data(MEM_stage_readdata),.MEM_ALUout(MEM_stage_ALUOUT),
                 .MEM_rd(MEM_stage_rd),.PCSrc(PCSrc_MEM),.EX_MEM(EX_MEM_ip));
    WB_stage  S5(.Write_data(Write_data),.Write_reg(Write_reg_addr),.RegWrite(RegWrite_cond),.MEM_WB(MEM_WB_ip));
    assign IF_stage.PCSrc      = PCSrc_MEM;
    assign ID_stage.RegWrite   = RegWrite_cond;
    assign ID_stage.MEM_WB_LMD = Write_data;
    always@(posedge clk) //IF_ID stage
        begin
            IF_ID[31:0]    = IF_IR;
            IF_ID[43:32]   = NPC;
        end
    always@(posedge clk) //ID_EX stage
        begin
            ID_EX[4:0]     = rd_dest1;
            ID_EX[9:5]     = rd_dest0;
            ID_EX[41:10]   = sign_extended_Imm;
            ID_EX[73:42]   = b;
            ID_EX[105:74]  = a;
            ID_EX[117:106] = IF_ID_NPC;
            ID_EX[126:118] = contr;
        end
    always@(posedge clk) //EX_MEM stage
        begin
           EX_MEM[4:0]     = EX_stage_rd;
           EX_MEM[36:5]    = EX_stage_B;
           EX_MEM[68:37]   = EX_stage_ALUop;
           EX_MEM[69]      = EX_stage_zero;
           EX_MEM[81:70]   = EX_stage_NPC;
           EX_MEM[83:82]   = EX_stage_WB;
           EX_MEM[86:84]   = EX_stage_MEM;
        end
    always@(posedge clk) //MEM_WB stage
        begin
            MEM_WB[4:0]    = MEM_stage_rd;
            MEM_WB[36:5]   = MEM_stage_ALUOUT;
            MEM_WB[68:37]  = MEM_stage_readdata;
            MEM_WB[70:69]  = MEM_stage_WB;
        end
endmodule
