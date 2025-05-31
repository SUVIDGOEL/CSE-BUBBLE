`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 04:24:12
// Design Name: 
// Module Name: general_register_file
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


module general_register_file(
    input reg_write,
    input clk,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    reg [31:0] regfile [0:31];
    assign read_data1 = (read_reg1 == 5'd0)?32'd0:regfile[read_reg1];
    assign read_data2 = (read_reg2 == 5'd0)?32'd0:regfile[read_reg2];
    always @(posedge clk)begin
        if(reg_write)begin
            regfile[write_reg] <= write_data;
        end
    end
endmodule
