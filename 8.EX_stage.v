`timescale 1ns / 1ns
module EX_stage(cont_MEM,cont_WB,NPC_ADD,ZERO,ALU_result,EX_B,EX_rd,ID_EX);
    input [126:0]ID_EX;
    wire [4:0]rd0;
    wire [4:0]rd1;
    wire [5:0]func_field;
    wire [31:0]ID_EX_Imm1,ID_EX_A,ID_EX_B;
    wire [11:0]ID_EX_NPC;
    wire [31:0]EX_NPC;
    wire ALUSrc,RegDst;
    wire [1:0]ALUOp;
    wire [31:0]ID_EX_Imm;
    reg [31:0]ALU_B;
    wire [3:0]cont_EXE;
    output wire [2:0]cont_MEM;
    output wire [1:0]cont_WB;
    output wire [11:0]NPC_ADD;
    output reg ZERO;
    output reg [31:0]ALU_result;
    output wire [31:0]EX_B;
    output reg [4:0]EX_rd;
    reg [31:0]NPC_sum;
    parameter ADD=6'b000000,SUB=6'b000001,AND=6'b000010,OR=6'b000011,MUL=6'b000101,
              ADDI=6'b001010,SUBI=6'b001011,
              LW=6'b001000,SW=6'b001001,
              BNEQZ=6'b001101,BEQZ=6'b001110;
    parameter LOAD=2'b00,STORE=2'b00,BRANCH=2'b01,RR_ALU=2'b10,RM_ALU=2'b11;
    assign rd1        = ID_EX[4:0];
    assign rd0        = ID_EX[9:5];
    assign ID_EX_Imm  = ID_EX[41:10];
    assign ID_EX_B    = ID_EX[73:42];
    assign ID_EX_A    = ID_EX[105:74];
    assign ID_EX_NPC  = ID_EX[117:106];
    assign cont_WB    = ID_EX[119:118];
    assign cont_MEM   = ID_EX[122:120];
    assign cont_EXE   = ID_EX[126:123];
    assign func_field = ID_EX_Imm[5:0];
    assign RegDst     = cont_EXE[3];
    assign ALUOp      = cont_EXE[2:1];
    assign ALUSrc     = cont_EXE[0];
    assign EX_NPC     = { { 20{ID_EX_NPC[11]} },ID_EX_NPC[11:0] };
    assign EX_B       = ID_EX_B;
    assign ID_EX_Imm1 = ID_EX_Imm<<2;
    assign NPC_ADD = NPC_sum[11:0];
    always@(ID_EX_NPC or ID_EX_Imm1)
        NPC_sum=EX_NPC+ID_EX_Imm1;
    always@(*)
        begin
            if(ALUSrc == 0)
                ALU_B=ID_EX_B;
            else if(ALUSrc == 1)
                ALU_B=ID_EX_Imm;
            case(ALUOp)
                RR_ALU :begin
                            case(func_field) 
                                ADD  : ALU_result =  ID_EX_A + ALU_B;
                                SUB  : ALU_result =  ID_EX_A - ALU_B;
                                AND  : ALU_result =  ID_EX_A & ALU_B;
                                OR   : ALU_result =  ID_EX_A | ALU_B;
                                MUL  : ALU_result =  ID_EX_A * ALU_B;
                                default: ALU_result =  32'h00000000;
                            endcase    
                        end
                RM_ALU :begin
                            case(func_field) 
                                ADDI   : ALU_result = #2 ID_EX_A + ALU_B;
                                SUBI   : ALU_result = #2 ID_EX_A - ALU_B;
                                default: ALU_result = #2 32'h00000000;
                            endcase
                        end
                LOAD,STORE :begin
                                case(func_field)
                                    LW: ALU_result =  ID_EX_A + ALU_B;
                                    SW: ALU_result =  ID_EX_A + ALU_B;
                                endcase
                            end
                BRANCH :begin
                            case(func_field)
                                BEQZ: begin
                                          ALU_result  =  ID_EX_A - ALU_B;
                                          if(ALU_result == 0)
                                              ZERO = 1;
                                      end    
                                BNEQZ: begin
                                       ALU_result  =  ID_EX_A - ALU_B;
                                       if(ALU_result != 0)
                                           ZERO = 1;
                                       end
                            endcase
                        end            
            endcase
        end
    initial ZERO = 1'b0;
    always@(*)
        if(RegDst==0)
                EX_rd = rd0;
            else if(RegDst == 1)
                EX_rd = rd1;
            else
                EX_rd = 5'b11111;
    
endmodule
