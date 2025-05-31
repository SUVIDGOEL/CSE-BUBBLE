`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 04:37:17
// Design Name: 
// Module Name: mux_dest_reg
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


module mux_dest_reg(
    input [4:0] rt,
    input [4:0] rd,
    input regdst,
    input mf,
    input regdst_jal,
    output [4:0] dest
);
    assign dest = (mf==1)?rt:(regdst_jal==1)?5'd31:(regdst == 1'b0)?rt:rd;
endmodule
