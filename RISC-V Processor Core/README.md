# RISC-V Single-Cycle Processor 



A Verilog implementation of the non-pipelined, single-cycle RISC-V RV32I processor, often referred to as the **"Simple Implementation"** in the computer architecture textbook *Computer Organization and Design* by Patterson and Hennessy (The RISC-V Edition).



## 🧠 Overview

This repository contains the source code for the non-pipelined, single-cycle RISC-V processor core described in Chapter 4 of Patterson and Hennessy. This design executes a complete instruction—from fetch to write-back—within a single, long clock cycle. It serves as the foundational model for understanding CPU operation before introducing the complexities of pipelining.

## ⏱️ The "Simple Implementation"

The "Simple Implementation" is characterized by its complete, non-pipelined datapath. Its key attributes are:
- **Single Clock Cycle per Instruction:** Every instruction requires one clock cycle to complete. The cycle time must be long enough to accommodate the slowest instruction's path (the `lw` instruction, which goes through instruction memory, register file, ALU, data memory, and back to the register file).
- **CPI = 1:** The Clocks Per Instruction (CPI) is always 1.
- **Simple Control:** The control logic is a pure combinational circuit that decodes the instruction and sets the control lines for the datapath. There are no pipeline registers, hazard detection, or forwarding units.
- **Educational Value:** This design perfectly illustrates the complete journey of an instruction through the processor and the critical role of the control unit, making it an invaluable learning tool.

## ⚙️ Features

- **ISA:** Implements a subset of the RV32I base instruction set.
- **Architecture:** Harvard-style architecture with separate Instruction and Data memories for clarity and simplicity.
- **Textbook Accuracy:** Follows the "Simple Implementation" datapath and control logic as described in the reference textbook.
- **Complete Components:** Includes all essential modules: Program Counter, Instruction Memory, Register File, ALU, Main Control Unit, ALU Control, Immediate Generator, and Data Memory.
- **Self-Checking Testbench:** Verified with a comprehensive testbench that validates the execution of arithmetic, memory access, and control-flow instructions.

## 🏗️ Datapath and Control

The design implements the canonical single-cycle datapath. The flow of data is governed by multiplexers and the control unit, which decodes the instruction and generates the following signals among others:
- **RegWrite:** Enables writing to the register file.
- **ALUSrc:** Selects between a register value and an immediate for the ALU's second operand.
- **ALUOp:** Instructs the ALU Control unit on the operation to perform.
- **MemWrite:** Enables writing to the data memory.
- **MemRead:** Enables reading from the data memory.
- **MemtoReg:** Selects whether the Writeback data comes from the ALU result or the Data Memory.


<img width="1012" height="783" alt="Screenshot from 2025-09-04 08-07-14" src="https://github.com/user-attachments/assets/8c624546-12dd-470c-982a-fba13c951577" />

