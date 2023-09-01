`timescale 1ns / 1ns
module ID_stage(sign_Imm,A,B,rd0,rd1,control_bits,IF_ID_IR,IF_ID_NPC);
    input [31:0]IF_ID_IR;
    input [11:0]IF_ID_NPC;
    output wire [31:0]sign_Imm;
    output wire [31:0]A,B;
    output wire [4:0]rd0,rd1;
    output wire [8:0]control_bits;
    wire [11:0]NPC_ID;
    wire [31:0]IR1;
    wire [4:0]s_rs,s_rt,rd;
    wire [5:0]opcode_IR;
    wire [31:0]Imm_sign_extend;
    wire [15:0]Imm;
    wire RegWrite;
    wire [31:0]MEM_WB_LMD;
    assign IR1=IF_ID_IR;
    assign opcode_IR=IR1[31:26];
    assign s_rs=IR1[25:21];
    assign s_rt=IR1[20:16];
    assign rd0 =IR1[20:16];
    assign rd1 =IR1[15:11];
    assign Imm=IR1[15:0];
    assign sign_Imm=Imm_sign_extend;
    control C1(.cont(control_bits),.opcode(opcode_IR));
    regbank_32 RB(.rs(A),.rt(B),.s_rs(s_rs),.s_rt(s_rt),.rd(rd),.wr_data(MEM_WB_LMD),.RegWrite(RegWrite));
    sign SE(.Y(Imm_sign_extend),.A(Imm));
endmodule
