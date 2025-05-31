`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 04:40:54
// Design Name: 
// Module Name: mux_input_2
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


module mux_input_2(
    input ALUsrc,
    input [31:0] read_data2,
    input [31:0] ext_out,
    output [31:0] input2
);
    assign input2 = (ALUsrc==0)?read_data2:ext_out;
endmodule
