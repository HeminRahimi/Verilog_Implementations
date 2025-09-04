# RISC-V Single-Cycle Processor 



A Verilog implementation of the non-pipelined, single-cycle RISC-V RV32I processor, often referred to as the **"Simple Implementation"** in the computer architecture textbook *Computer Organization and Design* by Patterson and Hennessy (The RISC-V Edition).



## Overview

This repository contains the source code for the non-pipelined, single-cycle RISC-V processor core described in Chapter 4 of Patterson and Hennessy. This design executes a complete instruction—from fetch to write-back—within a single, long clock cycle. It serves as the foundational model for understanding CPU operation before introducing the complexities of pipelining.

## The "Simple Implementation"

The "Simple Implementation" is characterized by its complete, non-pipelined datapath. Its key attributes are:
- **Single Clock Cycle per Instruction:** Every instruction requires one clock cycle to complete. The cycle time must be long enough to accommodate the slowest instruction's path (the `lw` instruction, which goes through instruction memory, register file, ALU, data memory, and back to the register file).
- **CPI = 1:** The Clocks Per Instruction (CPI) is always 1.
- **Simple Control:** The control logic is a pure combinational circuit that decodes the instruction and sets the control lines for the datapath. There are no pipeline registers, hazard detection, or forwarding units.
- **Educational Value:** This design perfectly illustrates the complete journey of an instruction through the processor and the critical role of the control unit, making it an invaluable learning tool.

## Features

- **ISA:** Implements a subset of the RV32I base instruction set.
- **Architecture:** Harvard-style architecture with separate Instruction and Data memories for clarity and simplicity.
- **Textbook Accuracy:** Follows the "Simple Implementation" datapath and control logic as described in the reference textbook.
- **Complete Components:** Includes all essential modules: Program Counter, Instruction Memory, Register File, ALU, Main Control Unit, ALU Control, Immediate Generator, and Data Memory.
- **Self-Checking Testbench:** Verified with a comprehensive testbench that validates the execution of arithmetic, memory access, and control-flow instructions.

## Datapath and Control

The design implements the canonical single-cycle datapath. The flow of data is governed by multiplexers and the control unit, which decodes the instruction and generates the following signals among others:
- **RegWrite:** Enables writing to the register file.
- **ALUSrc:** Selects between a register value and an immediate for the ALU's second operand.
- **ALUOp:** Instructs the ALU Control unit on the operation to perform.
- **MemWrite:** Enables writing to the data memory.
- **MemRead:** Enables reading from the data memory.
- **MemtoReg:** Selects whether the Writeback data comes from the ALU result or the Data Memory.


<img width="1012" height="783" alt="Screenshot from 2025-09-04 08-07-14" src="https://github.com/user-attachments/assets/8c624546-12dd-470c-982a-fba13c951577" />




## Instruction Set Support

The core supports the following instructions from the RV32I set, providing a complete demonstration of the major instruction formats:

| Type | Instruction | Example | Description |
| :--- | :--- | :--- | :--- |
| **R-Type** | `add`, `sub`, `and`, `or` | `add x1, x2, x3` | Register-Register Arithmetic |
| **I-Type** | `addi`, `andi`, `ori`, `lw` | `lw x1, 4(x2)` | Register-Immediate Arithmetic / Load |
| **S-Type** | `sw` | `sw x1, 8(x2)` | Store Word to Memory |
| **B-Type** | `beq` | `beq x1, x2, label` | Conditional Branch (Equal) |

## Simulation and Testing

### Prerequisites
- **Icarus Verilog** (`iverilog`) for simulation.
- **GTKWave** (optional) for viewing waveforms.

### Running the Testbench
1.  Download the "Codes" folder and run the simulation:
    ```bash
    # Run manually:
    iverilog -o [An Optional_Name, e.g., RISCV_SIM] /Path/To/The/Files/*.v  ./Path/To/The/Files/TB_top.v
    vvp RISCV_SIM
    ```

### Test Program
The test program validates the core functionality by using all supported instruction types and checking the results.

```asm
    addi x1, x0, 1       # x1 = 1
    addi x2, x0, 2       # x2 = 2
    add  x3, x1, x2      # x3 = 1 + 2 = 3 (R-type)
    addi x5, x0, 5       # x5 = 5 (I-type, base address)
    sw   x3, 0(x5)       # mem[5] = 3 (S-type)
    lw   x4, 0(x5)       # x4 = mem[5] = 3 (I-type, load)
    beq  x3, x4, end     # Branch should be taken (B-type)
    addi x6, x0, 999     # This instruction should be skipped

