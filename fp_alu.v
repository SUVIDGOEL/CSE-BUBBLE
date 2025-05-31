`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2025 06:32:39
// Design Name: 
// Module Name: fp_alu
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


module fp_alu(
    input [2:0] fp_ctl,
    input [31:0] din1,
    input [31:0] din2,
    input [4:0] shamt,
    input mov,
    input [4:0] rd,
    input [31:0] general_input,
    output reg cc_flag,
    output reg [4:0] fp_write_addr,
    output reg [31:0] fp_alures
);
    wire [31:0] temp_add;
    wire [31:0] temp_sub;
    wire cc_le,cc_lt,cc_ge,cc_gt,cc_eq;
    floating_point_0 fp_add( 
        .s_axis_a_tdata(din1),    // 32-bit float input A
        .s_axis_a_tvalid(1'b1),
        .s_axis_b_tdata(din2),    // 32-bit float input B
        .s_axis_b_tvalid(1'b1),
        .m_axis_result_tdata(temp_add),
        .m_axis_result_tvalid() // Optional valid signal
    );
    
    floating_point_1 fp_sub( 
        .s_axis_a_tdata(din1),    // 32-bit float input A
        .s_axis_a_tvalid(1'b1),
        .s_axis_b_tdata(din2),    // 32-bit float input B
        .s_axis_b_tvalid(1'b1),
        .m_axis_result_tdata(temp_sub),
        .m_axis_result_tvalid() // Optional valid signal
    );
    
    floating_point_2 fp_eq( 
        .s_axis_a_tdata(din1),    // 32-bit float input A
        .s_axis_a_tvalid(1'b1),
        .s_axis_b_tdata(din2),    // 32-bit float input B
        .s_axis_b_tvalid(1'b1),
        .m_axis_result_tdata(cc_eq),
        .m_axis_result_tvalid() // Optional valid signal
    );
    
    floating_point_3 fp_le( 
        .s_axis_a_tdata(din1),    // 32-bit float input A
        .s_axis_a_tvalid(1'b1),
        .s_axis_b_tdata(din2),    // 32-bit float input B
        .s_axis_b_tvalid(1'b1),
        .m_axis_result_tdata(cc_le),
        .m_axis_result_tvalid() // Optional valid signal
    );
    
    floating_point_4 fp_lt( 
        .s_axis_a_tdata(din1),    // 32-bit float input A
        .s_axis_a_tvalid(1'b1),
        .s_axis_b_tdata(din2),    // 32-bit float input B
        .s_axis_b_tvalid(1'b1),
        .m_axis_result_tdata(cc_lt),
        .m_axis_result_tvalid() // Optional valid signal
    );
    
    floating_point_5 fp_ge( 
        .s_axis_a_tdata(din1),    // 32-bit float input A
        .s_axis_a_tvalid(1'b1),
        .s_axis_b_tdata(din2),    // 32-bit float input B
        .s_axis_b_tvalid(1'b1),
        .m_axis_result_tdata(cc_ge),
        .m_axis_result_tvalid() // Optional valid signal
    );
    
    floating_point_6 fp_gt( 
        .s_axis_a_tdata(din1),    // 32-bit float input A
        .s_axis_a_tvalid(1'b1),
        .s_axis_b_tdata(din2),    // 32-bit float input B
        .s_axis_b_tvalid(1'b1),
        .m_axis_result_tdata(cc_gt),
        .m_axis_result_tvalid() // Optional valid signal
    );
   
    
    always @(*)begin
        fp_write_addr = shamt;
        case(fp_ctl)
            0:begin                
                if(mov)begin              //mov.s
                    fp_alures = din1;
                end
                else begin                //add.s
                    fp_alures = temp_add;
                end
            end
            1:fp_alures = temp_sub;
            2:cc_flag = cc_eq; //eq
            3:cc_flag = cc_lt; //lt
            4:cc_flag = cc_le; //le
            5:cc_flag = cc_ge; //ge
            6:cc_flag = cc_gt; //gt
            7:begin
                fp_alures = general_input;//mtc1
                fp_write_addr = rd;
            end
            default:begin
                fp_alures = 32'd0;
                cc_flag = 0;
            end
        endcase
    end
endmodule
