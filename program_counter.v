`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 00:42:33
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input clk,
    input rst,
    input [31:0] pc_next,
    output reg [31:0] pc
);
    always @(posedge clk or posedge rst)begin
        if(rst) pc <= 0;
        else pc <= pc_next;
    end
endmodule
