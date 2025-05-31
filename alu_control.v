`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 01:46:30
// Design Name: 
// Module Name: alu_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//ALUctl (4-bit)	Operation	Used For
//0000	             AND	    R-type and
//0001	              OR	    R-type or
//0010	             ADD	 add, addi, lw, sw
//0011	             LUI	    lui
//0100	             XOR	    R-type xor
//0101	             NOT	    R-type not
//0110	             SUB	    sub, beq, bne
//0111	             SLT	    slt, slti
//1000	             SLL	    sll
//1001	             SRL	    srl
//1010	             SRA	    sra
//1011               MULT       mult
//1100               JR         jr
//1101               MADD       madd
//1110               SUBU       subu
//1111               MFC1       mfc1

module alu_control(
    input [1:0] ALUOp,
    input [5:0] funct,
    input [6:0] opcode,
    input [31:0] instruction,
    output reg [3:0] ALUctl
);
    always @(*)begin
        if(opcode == 6'h11)begin
            if(instruction[25:21] == 5'd0)begin       //mfc1
                ALUctl = 4'b1111;
            end
        end
        else begin
        case(ALUOp)
            0:ALUctl = 4'b0010; //lw,sw
            1:ALUctl = 4'b1110; //beq,bne,bgt,bgte,ble,bleq,bleu,bgtu
            2:begin
                case (funct)
                    0: ALUctl = 4'b1000; //sll
                    2: ALUctl = 4'b1001; //srl
                    3: ALUctl = 4'b1010; //sra
//                    8: ALUctl = 4'b1100; //jr
                    6'h18:ALUctl = 4'b1011; //mult
                    6'h20: ALUctl = 4'b0010; //add
                    6'h21: ALUctl = 4'b0010; //add
                    6'h22: ALUctl = 4'b0110; //sub
                    6'h23: ALUctl = 4'b1110; //subu
                    6'h24: ALUctl = 4'b0000; //and
                    6'h25: ALUctl = 4'b0001; //or
                    6'h26: ALUctl = 4'b0100; //xor
                    6'h27: ALUctl = 4'b0101; //not
                    6'h2a: ALUctl = 4'b0111; //slt
                endcase
            end
            3:begin
                case(opcode)
                    6'h08: ALUctl = 4'b0010; //addi
                    6'h09: ALUctl = 4'b0010; //addiu
                    6'h0c: ALUctl = 4'b0000; //andi
                    6'h0d: ALUctl = 4'b0001; //ori
                    6'h0e: ALUctl = 4'b0100; //xori
                    6'h0a: ALUctl = 4'b0111; //slti
                    6'h0b: ALUctl = 4'b0110; //seq
                    6'h0f: ALUctl = 4'b0011; //lui
                    6'h1c: ALUctl = 4'b1101; //madd
                    6'h1d: ALUctl = 4'b1101; //maddu
//                    6'h06: ALUctl = 4'b0110; //bgt
//                    6'h07: ALUctl = 4'b0110; //bgte
//                    6'h30: ALUctl = 4'b0110; //ble
//                    6'h31: ALUctl = 4'b0110; //bleq
//                    6'h32: ALUctl = 4'b0110; //bleu
//                    6'h33: ALUctl = 4'b0110; //bgtu
                endcase
            end
            default: ALUctl = 4'bxxxx;  // Or a safe default value
        endcase
        end
    end
endmodule
