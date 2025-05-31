`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 19:34:16
// Design Name: 
// Module Name: mux_memtoreg
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


module mux_memtoreg(
    input memtoreg,
    input regdst_jal,
    input [31:0] input1,
    input [31:0] input2,
    input [31:0] pc_plus_4,
    output [31:0] dout
);
    assign dout = (regdst_jal)?pc_plus_4:(memtoreg == 0)?input1:input2;
endmodule
