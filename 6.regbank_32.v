`timescale 1ns / 1ns
module regbank_32(rs,rt,s_rs,s_rt,rd,wr_data,RegWrite);
    input [4:0]s_rs,s_rt,rd; //source and destination registers
    input [31:0] wr_data; // write data
    input RegWrite;
    output reg [31:0]rs,rt; // reg1,reg2
    reg [31:0]regfile[0:31]; // Register bank
    always@(*)
        begin
            rs=regfile[s_rs];
            rt=regfile[s_rt];
            if(RegWrite == 1)
                regfile[rd]=wr_data;
        end
    initial
        begin
            regfile[0]=32'h00000000;
            regfile[1]=32'h0000ff01;
            regfile[2]=32'h0000ff02;
            regfile[3]=32'h0000ff03;
            regfile[4]=32'h0000ff04;
            regfile[5]=32'h0000ff05;
            regfile[6]=32'h0000ff06;
            regfile[7]=32'h0000ff07;
            regfile[8]=32'h0000ff08;
            regfile[9]=32'h0000ff09;
            regfile[10]=32'h0000ff0a;
            regfile[11]=32'h0000ff0b;
            regfile[12]=32'h0000ff0c;
            regfile[13]=32'h0000ff0d;
            regfile[14]=32'h0000ff0e;
            regfile[15]=32'h0000ff0f;
            regfile[16]=32'h0000ff10;
            regfile[17]=32'h0000ff11;
            regfile[18]=32'h0000ff12;
            regfile[19]=32'h0000ff13;
            regfile[20]=32'h0000ff14;
            regfile[21]=32'h0000ff15;
            regfile[22]=32'h0000ff16;
            regfile[23]=32'h0000ff17;
            regfile[24]=32'h0000ff18;
            regfile[25]=32'h00000000;
            regfile[26]=32'h00000000;
            regfile[27]=32'h00000000;
            regfile[28]=32'h00000000;
            regfile[29]=32'h00000000;
            regfile[30]=32'h00000000;
            regfile[31]=32'h00000000;
        end 
endmodule
