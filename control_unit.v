`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 18:22:18
// Design Name: 
// Module Name: control_unit
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


//module control_unit(
//    input [31:0] instruction,
//    output regdst,
//    output ALUsrc,
//    output mem_read,
//    output mem_write,
//    output jump,
//    output branch,
//    output memtoreg,
//    output reg [1:0] ALUOp,
//    output reg reg_write
//);
//    assign regdst = (instruction[31:26] == 0)?1'b1:1'b0;
//    assign ALUsrc = (instruction[31:26] == 0)?1'b0:1'b1;
//    assign mem_read = (instruction[31:26] == 6'h23)?1'b1:1'b0;
//    assign mem_write = (instruction[31:26] == 6'h2b)?1'b1:1'b0;
//    assign jump = ((instruction[31:26] == 6'h02) || (instruction[31:26]==6'h03) || (instruction[31:26]==6'h00 && instruction[5:0]==6'h08))?1'b1:1'b0;
//    assign branch = ((instruction[31:26]==6'h06) || (instruction[31:26]==6'h07) || (instruction[31]&instruction[30] == 1'b1))?1'b1:1'b0;
//    assign memtoreg = (instruction[31:26]==6'h00)?1'b0:1'b1;
//    always @(*)begin
//        case(instruction[31:26])
//            0:reg_write = 1'b1;
//            6'h08:reg_write = 1'b1;
//            6'h09:reg_write = 1'b1;
//            6'h0c:reg_write = 1'b1;
//            6'h0d:reg_write = 1'b1;
//            6'h0e:reg_write = 1'b1;
//            6'h23:reg_write = 1'b1;
//            6'h0f:reg_write = 1'b1;
//            default: reg_write = 1'b0;
//        endcase
//    end
//    always @(*)begin
//        case(instruction[31:26])
//            6'h23:ALUOp = 2'b00;
//            6'h2b:ALUOp = 2'b00;
//            6'h04:ALUOp = 2'b01;
//            6'h05:ALUOp = 2'b01;
//            6'h00:ALUOp = 2'b10;
//            default:ALUOp = 2'b11;
//        endcase
//    end
//endmodule

//module control_unit(
//    input [31:0] instruction,
//    output reg regdst,
//    output reg ALUsrc,
//    output reg mem_read,
//    output reg mem_write,
//    output reg jump,
//    output reg branch,
//    output reg memtoreg,
//    output reg [1:0] ALUOp,
//    output reg reg_write
//);
//    wire [5:0] opcode = instruction[31:26];

//    always @(*) begin
//        case (opcode)
//            6'h00: begin  // R-type
//                regdst    = 1;
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 0;
//                memtoreg  = 0;
//                ALUOp     = 2'b10;
//                reg_write = 1;
//            end
//            6'h23: begin  // lw
//                regdst    = 0;
//                ALUsrc    = 1;
//                mem_read  = 1;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 0;
//                memtoreg  = 1;
//                ALUOp     = 2'b00;
//                reg_write = 1;
//            end
//            6'h2b: begin  // sw
//                regdst    = 0;  // don't care
//                ALUsrc    = 1;
//                mem_read  = 0;
//                mem_write = 1;
//                jump      = 0;
//                branch    = 0;
//                memtoreg  = 0;  // don't care
//                ALUOp     = 2'b00;
//                reg_write = 0;
//            end
//            6'h04: begin  // beq
//                regdst    = 0;  // don't care
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 1;
//                memtoreg  = 0;  // don't care
//                ALUOp     = 2'b01;
//                reg_write = 0;
//            end
//            6'h05: begin  // bne ? added
//                regdst    = 0;  // don't care
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 1;
//                memtoreg  = 0;  // don't care
//                ALUOp     = 2'b01;
//                reg_write = 0;
//            end
//            6'h02: begin  // j
//                regdst    = 0;
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 1;
//                branch    = 0;
//                memtoreg  = 0;
//                ALUOp     = 2'b00;
//                reg_write = 0;
//            end
//            6'h06: begin //bgt
//                regdst    = 0;
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 1;
//                memtoreg  = 0;
//                ALUOp     = 2'b01;
//                reg_write = 0;
//            end
//            6'h07: begin //bgte
//                regdst    = 0;
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 1;
//                memtoreg  = 0;
//                ALUOp     = 2'b01;
//                reg_write = 0;
//            end
//            6'h30: begin //ble
//                regdst    = 0;
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 1;
//                memtoreg  = 0;
//                ALUOp     = 2'b01;
//                reg_write = 0;
//            end
//            6'h31: begin //bleq
//                regdst    = 0;
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 1;
//                memtoreg  = 0;
//                ALUOp     = 2'b01;
//                reg_write = 0;
//            end
//            6'h32: begin //bleu
//                regdst    = 0;
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 1;
//                memtoreg  = 0;
//                ALUOp     = 2'b01;
//                reg_write = 0;
//            end
//            6'h33: begin //bgtu
//                regdst    = 0;
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 1;
//                memtoreg  = 0;
//                ALUOp     = 2'b01;
//                reg_write = 0;
//            end
//            default: begin
//                regdst    = 0;
//                ALUsrc    = 0;
//                mem_read  = 0;
//                mem_write = 0;
//                jump      = 0;
//                branch    = 0;
//                memtoreg  = 0;
//                ALUOp     = 2'b00;
//                reg_write = 0;
//            end
//        endcase
//    end
//endmodule

module control_unit(
    input [31:0] instruction,
    input cc_flag,
    output reg regdst,
    output reg ALUsrc,
    output reg mem_read,
    output reg mem_write,
    output reg jump,
    output reg jump_reg,     // NEW: for jr
    output reg regdst_jal,   // NEW: for jal to write to $ra
    output reg branch,
    output reg branch_gt,
    output reg branch_gte,
    output reg branch_lt,
    output reg branch_lte,
    output reg branch_gt_u,
    output reg branch_lte_u,
    output reg branch_ne,
    output reg memtoreg,
    output reg [1:0] ALUOp,
    output reg reg_write,
    output reg hi_lo_reg_write,
    output reg fp_reg_write,
    output reg [2:0] fp_ctl,
    output reg mf,
    output reg mov
);
    wire [5:0] opcode = instruction[31:26];
    wire [5:0] funct  = instruction[5:0];

    always @(*) begin
        // Default values (safe NOP-style defaults)
        regdst      = 0;
        ALUsrc      = 0;
        mem_read    = 0;
        mem_write   = 0;
        jump        = 0;
        jump_reg    = 0;
        regdst_jal  = 0;
        branch      = 0;
        memtoreg    = 0;
        ALUOp       = 2'b00;
        reg_write   = 0;
        hi_lo_reg_write = 0;
        fp_reg_write = 0;
        fp_ctl = 3'b000;
        mf=0;
        mov = 0;
        
        branch_gt     = 0;
        branch_gte    = 0;
        branch_lt     = 0;
        branch_lte    = 0;
        branch_gt_u   = 0;
        branch_lte_u  = 0;
        branch_ne     = 0;

        case (opcode)
            
            6'b010001:begin //Foating point opcode (Add and Sub) 
                if(instruction[25:21] == 5'b00000)begin   //mfc1
                    mf = 1'b1;
                    reg_write = 1'b1;
                end   
                else if(instruction[25:21] == 5'b00100)begin   //mtc1
                    fp_reg_write = 1'b1;
                    fp_ctl = 3'b111;
                end 
                else begin
                case(funct)
                    6'h00:begin
                        fp_ctl = 3'b000; //add
                        fp_reg_write = 1'b1;
                    end
                    6'h01:begin
                        fp_ctl = 3'b001; //sub 
                        fp_reg_write = 1'b1;
                    end
                    6'h32:fp_ctl = 3'b010; //c.eq.s
                    6'h3c:fp_ctl = 3'b011; //C.lt.s
                    6'h3e:fp_ctl = 3'b100; //c.le.s
                    6'h3d:fp_ctl = 3'b101; //c.ge.s
                    6'h3f:fp_ctl = 3'b110; //c.gt.s
                    6'h06:begin            //mov.s
                        fp_ctl = 3'b000;
                        fp_reg_write =  cc_flag;
                        mov = 1'b1;     
                    end
                endcase
                end
            end
            6'b000111: begin // bgt
                branch_gt = 1;
                ALUOp = 2'b01;
            end
            6'b000110: begin // bgte
                branch_gte = 1;
                ALUOp = 2'b01;
            end
            6'b000101: begin // ble
                branch_lt = 1;
                ALUOp = 2'b01;
            end
            6'b001000: begin // bleq
                branch_lte = 1;
                ALUOp = 2'b01;
            end
            6'b001001: begin // bleu
                branch_lte_u = 1;
                ALUOp = 2'b01;
            end
            6'b001010: begin // bgtu
                branch_gt_u = 1;
                ALUOp = 2'b01;
            end
            6'h00: begin  // R-type or JR
                if (funct == 6'h08) begin  // jr
                    jump_reg  = 1;
                    reg_write = 0;
                end 
                else if(funct == 6'h18)begin //mult
                    regdst    = 1;
                    ALUsrc    = 0;
                    mem_read  = 0;
                    mem_write = 0;
                    jump      = 0;
                    branch    = 0;
                    memtoreg  = 0;
                    ALUOp     = 2'b10;
                    reg_write = 0;
                    hi_lo_reg_write = 1;
                end
                else begin  // normal R-type
                    regdst    = 1;
                    ALUsrc    = 0;
                    mem_read  = 0;
                    mem_write = 0;
                    jump      = 0;
                    branch    = 0;
                    memtoreg  = 0;
                    ALUOp     = 2'b10;
                    reg_write = 1;
                end
            end
            6'h03: begin  // jal
                jump        = 1;
                reg_write   = 1;
                regdst_jal  = 1;
                memtoreg    = 0;  // return address goes to $ra, not memory
            end
            6'h23: begin  // lw
                regdst    = 0;
                ALUsrc    = 1;
                mem_read  = 1;
                mem_write = 0;
                jump      = 0;
                branch    = 0;
                memtoreg  = 1;
                ALUOp     = 2'b00;
                reg_write = 1;
            end
            6'h2b: begin  // sw
                ALUsrc    = 1;
                mem_write = 1;
            end
            6'h05:begin   // bne
                branch_ne = 1;
                ALUOp = 2'b01; 
            end       
            6'h04: begin  // beq
                branch = 1;
                ALUOp  = 2'b01;
            end
            6'h02: begin  // j
                jump = 1;
            end
        endcase
    end
endmodule


