`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 18:41:46
// Design Name: 
// Module Name: datapath
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


module datapath(
    input clk,
    input rst
);
    //Program Counter elements
    wire [31:0] pc;
    wire [31:0] pc_next,pc_plus_4,branch_addr;
    reg [31:0] hi, lo;
    program_counter pc_counter(.clk(clk), .rst(rst), .pc_next(pc_next), .pc(pc));
    
    //PC_Adder
    pc_adder pc_add(.pc(pc), .pc_plus_4(pc_plus_4));
    
    
    //Instruction Fetch
    wire [31:0] instruction;
    instruction_memory inst_fetch(.addr(pc[9:0]), .instruction(instruction));
    
    //Instruction Decode
    wire [5:0] opcode, funct;
    wire [4:0] rs,rt,rd,shamt;
    wire [15:0] immediate;
    wire [25:0] jump_target;
    instruction_decode id(.instruction(instruction),.opcode(opcode),.funct(funct), .rs(rs), .rt(rt), .rd(rd), .shamt(shamt), .immediate(immediate), .jump_target(jump_target));
    
    //Control Unit
    wire hi_lo_reg_write;
    wire fp_reg_write, mf;
    wire [31:0] fp_write_data, fp_read_data1, fp_read_data2;
    wire regdst, ALUsrc, mem_read, mem_write, reg_write, jump, jump_reg, regdst_jal, branch, memtoreg;
    wire branch_gt,branch_gte,branch_lt,branch_lte, branch_lte_u,branch_gt_u,branch_ne;
    wire [1:0] ALUOp;
    wire [2:0] fp_ctl;
    wire cc_flag;
    wire mov;
    control_unit cu(
        .instruction(instruction),
        .cc_flag(cc_flag),
        .mem_read(mem_read),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .regdst(regdst),
        .ALUsrc(ALUsrc),
        .jump(jump),
        .branch_gt(branch_gt),
        .branch_gte(branch_gte),
        .branch_lt(branch_lt),
        .branch_lte(branch_lte),
        .branch_lte_u(branch_lte_u),
        .branch_gt_u(branch_gt_u),
        .branch_ne(branch_ne),
        .jump_reg(jump_reg),
        .regdst_jal(regdst_jal),
        .branch(branch),
        .memtoreg(memtoreg),
        .ALUOp(ALUOp),
        .hi_lo_reg_write(hi_lo_reg_write),
        .fp_ctl(fp_ctl),
        .fp_reg_write(fp_reg_write),
        .mf(mf),
        .mov(mov)
    );
    
    //Mux destination register
    wire [4:0] write_reg;
    mux_dest_reg mux_dr(.rt(rt), .rd(rd), .regdst(regdst), .mf(mf), .regdst_jal(regdst_jal), .dest(write_reg));
    
    //Register_File
    wire [31:0] write_data, read_data1, read_data2;
    general_register_file reg_file(.reg_write(reg_write), .clk(clk), .read_reg1(rs), .read_reg2(rt), .write_reg(write_reg),.write_data(write_data), .read_data1(read_data1), .read_data2(read_data2));
    
    //Floating Point Register File
    wire [4:0] fp_write_addr;
    fpu_register_file fp_regfile(
        .clk(clk),
        .we(fp_reg_write),                    
        .raddr1(rd), 
        .raddr2(rt),   
        .waddr(fp_write_addr),               
        .wdata(fp_write_data),             
        .rdata1(fp_read_data1), 
        .rdata2(fp_read_data2)    
    );
    
    //Floating Point Unit
    fp_alu fpu_unit(
        .fp_ctl(fp_ctl),
        .din1(fp_read_data1),
        .din2(fp_read_data2),
        .shamt(shamt),
        .rd(rd),
        .mov(mov),
        .general_input(read_data2),
        .cc_flag(cc_flag),
        .fp_write_addr(fp_write_addr),
        .fp_alures(fp_write_data)
    );
    
    //Sign_Extension
    wire [31:0] ext_out;
    sign_extend sign_ext(.immediate(immediate), .ext_out(ext_out));
    
    //Mux_input 2
    wire [31:0] input2;
    mux_input_2 mux_inp2(.ALUsrc(ALUsrc), .read_data2(read_data2), .ext_out(ext_out), .input2(input2));
    
    //ALU_Control
    wire [3:0] ALUctl;
    alu_control alu_ct(.ALUOp(ALUOp), .funct(funct), .opcode(opcode), .instruction(instruction),.ALUctl(ALUctl));
    
    //ALU
    wire [31:0] ALU_result;
    wire zero_out, set_less, set_less_equal, set_greater, set_great_equal;
    wire set_greater_u, set_less_u;
    wire [31:0] temp_hi, temp_lo;
    alu alu_unit(
        .ALUctl(ALUctl),
        .din1(read_data1),
        .din2(input2), 
        .fp_input(fp_read_data1),
        .zero_out(zero_out),
        .set_less(set_less),
        .set_less_equal(set_less_equal),
        .set_greater(set_greater),
        .set_great_equal(set_great_equal),
        .set_greater_u(set_greater_u),
        .set_less_u(set_less_u),
        .dout(ALU_result),
        .hi(temp_hi),
        .lo(temp_lo)
    );
    
    //Data Memory 
    wire [31:0] mem_data_out;
    data_memory data_mem(.clk(clk), .mem_write(mem_write), .mem_read(mem_read), .addr(ALU_result), .din(read_data2), .read_data(mem_data_out));
    
    //Mux Mem to Reg
    mux_memtoreg mux_write(.memtoreg(memtoreg), .regdst_jal(regdst_jal), .input1(ALU_result), .input2(mem_data_out), .dout(write_data));
    
    //Branch Address Adder
    branch_adder branch_add(.pc_plus_4(pc_plus_4), .ext_out(ext_out), .branch_addr(branch_addr));
    
    //Program Counter Mux
    mux_pc mux_pc_unit(
        pc_plus_4,
        branch_addr,
        read_data1,
        branch,
        branch_gt,
        branch_gte,
        branch_lt,
        branch_lte,
        branch_gt_u,
        branch_lte_u,
        branch_ne,
        set_greater,
        set_great_equal,
        set_less,
        set_less_equal,
        set_greater_u,
        set_less_u,
        jump_reg,
        jump,
        jump_target,
        zero_out,
        pc_next
    );
    
    always @(posedge clk or posedge rst)begin
        if(rst)begin
            hi <= 0;
            lo <= 0;
        end
        else if(hi_lo_reg_write)begin
            hi <= temp_hi;
            lo <= temp_lo;
        end
    end
    
    
endmodule
