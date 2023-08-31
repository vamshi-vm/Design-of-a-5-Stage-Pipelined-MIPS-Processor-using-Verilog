`timescale 1ns / 1ns
module control(cont, opcode);
    input [5:0] opcode;
    reg [1:0] control_WB;
    reg [2:0] control_MEM;
    reg [3:0] control_EX;
    output reg [8:0] cont;

    parameter R_format = 6'b111111,
              I_format = 6'b000011,
              LW       = 6'b100011,
              SW       = 6'b101011,
              beq      = 6'b000100;
              
    always @(*)
        begin
        case (opcode)
            R_format: begin
                      control_EX  = 4'b1100;
                      control_MEM = 3'b000;
                      control_WB  = 2'b10;
                      end
            I_format: begin
                      control_EX  = 4'b0111;
                      control_MEM = 3'b000;
                      control_WB  = 2'b10;
                      end
            LW:       begin
                      control_EX  = 4'b0001;
                      control_MEM = 3'b010;
                      control_WB  = 2'b11;
                      end
            SW:       begin
                      control_EX  = 4'b0001;
                      control_MEM = 3'b001;
                      control_WB  = 2'b00;
                      end
            beq:      begin
                      control_EX  = 4'b0010;
                      control_MEM = 3'b100;
                      control_WB  = 2'b00;
                      end
            default:  begin
                      control_EX  = 4'b0000;
                      control_MEM = 3'b000;
                      control_WB  = 2'b00;
                      end
        endcase
        end
    always @(*)
        begin
            cont = {control_EX, control_MEM, control_WB};
        end
endmodule
