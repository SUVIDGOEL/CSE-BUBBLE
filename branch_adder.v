`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 18:02:36
// Design Name: 
// Module Name: branch_adder
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


module branch_adder(
    input [31:0] pc_plus_4,
    input [31:0] ext_out,
    output [31:0] branch_addr
);
    assign branch_addr = pc_plus_4 + ext_out;
endmodule
