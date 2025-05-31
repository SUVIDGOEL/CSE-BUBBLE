`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 00:47:17
// Design Name: 
// Module Name: alu
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


module alu(
    input [3:0] ALUctl,
    input [31:0] din1,
    input [31:0] din2,
    input [31:0] fp_input,
    output zero_out,
    output set_less,
    output set_less_u,
    output set_greater_u,
    output set_less_equal,
    output set_greater,
    output set_great_equal,
    output reg [31:0] dout,
    output reg [31:0] hi,
    output reg [31:0] lo
);
    reg [31:0] temp;
    assign zero_out = (dout==0)?1'b1:1'b0;
    assign set_greater = ($signed(dout) > 0)?1'b1:1'b0;
    assign set_great_equal = ($signed(dout) >= 0)?1'b1:1'b0;
    assign set_less = ($signed(dout) < 0)? 1'b1:1'b0;
    assign set_less_equal = ($signed(dout) <= 0)? 1'b1:1'b0;
    assign set_less_u = (dout < 0)?1'b1:1'b0;
    assign set_greater_u = (dout > 0)?1'b1:1'b0;
    always @(*)begin
        case(ALUctl)
            0:dout = din1 & din2;
            1:dout = din1 | din2;
            2:dout = din1 + din2;
            3:dout = {din2[15:0], 16'b0};
            4:dout = din1 ^ din2;
            5:dout = ~din1;
            6:dout = din1 - din2;
            7:dout = din1 - din2;
            8:dout = din1 << din2;
            9:dout = din1 >> din2;
            10:dout = $signed(din1) >>> din2;
            11:begin
                dout = din1 * din2;
                {hi, lo} = din1 * din2;
            end
            12:dout = din1;
            13:{hi, lo} = {hi, lo} + din1*din2;
            14:dout = $signed(din1) - $signed(din2);
            15:dout = fp_input;
            default: dout = 32'b0;
        endcase
    end
endmodule
