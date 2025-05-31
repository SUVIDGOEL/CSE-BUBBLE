`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2025 06:14:14
// Design Name: 
// Module Name: fpu_register_file
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


module fpu_register_file (
    input clk,
    input we,                        // write enable
    input [4:0] raddr1, raddr2,      // read addresses
    input [4:0] waddr,               // write address
    input [31:0] wdata,             // write data
    output [31:0] rdata1, rdata2    // read data
);

    reg [31:0] fregs[0:31];
    
    initial
    begin
        fregs[0] = 32'h40600000; //3.5
        fregs[1] = 32'h3FA00000; //1.25
    end

    always @(posedge clk) begin
        if (we)
            fregs[waddr] <= wdata;
    end

    assign rdata1 = fregs[raddr1];
    assign rdata2 = fregs[raddr2];

endmodule

