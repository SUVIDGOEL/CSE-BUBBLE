`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 18:18:28
// Design Name: 
// Module Name: mux_pc
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


module mux_pc(
    input [31:0] pc_plus_4,
    input [31:0] branch_addr,
    input [31:0] read_data1,
    input branch,
    input branch_gt,
    input branch_gte,
    input branch_lt,
    input branch_lte,
    input branch_gt_u,
    input branch_lte_u,
    input branch_ne,
    input set_greater,
    input set_great_equal,
    input set_less,
    input set_less_equal,
    input set_greater_u,
    input set_less_u,
    input jump_reg,
    input jump,
    input [31:0] jump_target,
    input zero_out,
    output [31:0] pc_next
);
    wire pc_src;

    assign pc_src =
    (branch        && zero_out)           ||  
    (branch_gt     && set_greater)        ||  
    (branch_gte    && set_great_equal)    ||  
    (branch_lt     && set_less)           ||  
    (branch_lte   && set_less_equal)     ||  
    (branch_gt_u   && set_greater_u)      || 
    (branch_lte_u  && set_less_u)         ||
    (branch_ne     && ~(zero_out));      
    assign pc_next = (jump_reg == 1)?read_data1:(jump==1)?{pc_plus_4[31:26], jump_target}:(pc_src == 0) ? pc_plus_4:branch_addr;
endmodule
