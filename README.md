# IITK Mini MIPS Processor

## Project Overview
The IITK Mini MIPS Processor is a hardware implementation of a MIPS architecture processor with floating-point capabilities. This processor is designed using Verilog and implemented on a Xilinx FPGA platform using Vivado.

## Architecture
This processor implements a single-cycle MIPS architecture with the following key features:
- Standard R-type, I-type, and J-type instruction support
- Extended branch instructions (BGT, BGTE, BLT, BLTE, etc.)
- Floating-point operations
- HI/LO register support for multiplication
- Memory operations (load/store)
- Jump and branch instructions

## Module Structure

### Core Components
1. **Datapath (`datapath.v`)**: The main processor module that connects all components
2. **Program Counter (`program_counter.v`)**: Holds the address of the current instruction
3. **ALU (`alu.v`)**: Arithmetic Logic Unit that performs operations like ADD, SUB, AND, OR, etc.
4. **Control Unit (`control_unit.v`)**: Generates control signals based on the opcode
5. **Instruction Memory (`instruction_memory.v`)**: Stores the program instructions
6. **Data Memory (`data_memory.v`)**: Stores data that can be loaded and stored

### Register Files
1. **General Register File (`general_register_file.v`)**: Contains 32 general-purpose registers
2. **FPU Register File (`fpu_register_file.v`)**: Contains floating-point registers

### Decoders and ALU Control
1. **Instruction Decode (`instruction_decode.v`)**: Extracts fields from instructions
2. **ALU Control (`alu_control.v`)**: Generates ALU control signals based on opcode and function code

### Arithmetic Units
1. **FP ALU (`fp_alu.v`)**: Floating-point Arithmetic Logic Unit
2. **Branch Adder (`branch_adder.v`)**: Calculates branch target addresses
3. **PC Adder (`pc_adder.v`)**: Increments the program counter

### Multiplexers
1. **MUX Destination Register (`mux_dest_reg.v`)**: Selects the destination register
2. **MUX Input 2 (`mux_input_2.v`)**: Selects the second input for the ALU
3. **MUX Memory to Register (`mux_memtoreg.v`)**: Selects between ALU result and memory data
4. **MUX PC (`mux_pc.v`)**: Selects the next program counter value

### Utility Modules
1. **Sign Extend (`sign_extend.v`)**: Extends immediate values from 16 to 32 bits

## Instruction Set

### R-type Instructions
- ADD, SUB, AND, OR, XOR, NOT, SLT, SLL, SRL, SRA, MULT, SUBU

### I-type Instructions
- ADDI, ADDIU, ANDI, ORI, XORI, SLTI, SEQ, LUI, LW, SW

### J-type Instructions
- J, JAL, JR

### Branch Instructions
- BEQ, BNE, BGT, BGTE, BLT, BLTE, BLTU, BGTU

### Floating-point Instructions
- ADD.S, SUB.S, C.EQ.S, C.LT.S, C.LE.S, C.GE.S, C.GT.S, MOV.S
- MFC1, MTC1

## ALU Operations
The ALU supports the following operations (encoded by ALUctl):
- 0000: AND
- 0001: OR
- 0010: ADD
- 0011: LUI
- 0100: XOR
- 0101: NOT
- 0110: SUB
- 0111: SLT
- 1000: SLL
- 1001: SRL
- 1010: SRA
- 1011: MULT
- 1110: SUBU
- 1111: MFC1

## Memory Organization
- Instruction Memory: Uses `dist_mem_gen_0` IP core
- Data Memory: Uses `dist_mem_gen_1` IP core

## Implementation Details
- The processor is a single-cycle design where each instruction is executed in one clock cycle
- The floating-point unit uses Xilinx IP cores (`floating_point_*`) for operations
- HI/LO registers are implemented for handling multiplication results

## Usage
1. Open the project in Xilinx Vivado
2. Synthesize and implement the design
3. Generate the bitstream
4. Program the target FPGA device

## Dependencies
- Xilinx Vivado Design Suite
- Xilinx IP Cores:
  - `dist_mem_gen_0` for instruction memory
  - `dist_mem_gen_1` for data memory
  - `floating_point_0` through `floating_point_6` for FP operations

## Notes
- The PC adder increments by 1 rather than 4, meaning the instruction memory is addressed by words, not bytes
- HI/LO registers are updated with multiplication results
- There is no pipeline implementation; this is a single-cycle processor