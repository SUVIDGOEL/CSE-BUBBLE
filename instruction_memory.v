`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 00:22:39
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(
    input [9:0] addr,
    output [31:0] instruction
);
    dist_mem_gen_0 memory(
        .a(addr),
        .d(32'd0),
        .we(1'b0),
        .clk(1'b0),
        .spo(instruction)
    );
endmodule
