`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 00:25:49
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input clk,
    input mem_write,
    input mem_read,
    input [31:0] addr,
    input [31:0] din,
    output [31:0] read_data
);
    dist_mem_gen_1 memory(
        .a(addr[9:0]),
        .d(din),
        .we(mem_write),
        .clk(clk),
        .spo(read_data)
    );
endmodule
