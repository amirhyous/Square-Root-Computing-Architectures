# FPGA Square Root Architectures: VHDL Implementation & Benchmarking

[cite_start]This repository contains five distinct VHDL architectures designed to compute the integer square root of a 32-bit unsigned integer[cite: 3, 58]. [cite_start]The project evaluates different hardware design trade-offs, including iterative algorithms, fully combinatorial logic, and pipelined structures[cite: 409].

## 🚀 Overview
[cite_start]The project was developed at **Télécom Paris** to explore efficient FPGA-based arithmetic[cite: 1, 2, 5]. [cite_start]Each architecture was synthesized for the **Cyclone II (EP2C20F484C7)** and benchmarked using **Quartus II 13.0.1**[cite: 66, 67].

## 🏗️ Architectures

### 1. Newton-Raphson Method
* [cite_start]**Logic**: Iterative calculation based on the formula $x_{n+1} = \frac{1}{2}(x_{n} + \frac{A}{x_{n}})$[cite: 15, 16].
* [cite_start]**Constraint**: High resource usage due to the division operator[cite: 410].
* [cite_start]**Latency**: Variable based on the input value $A$[cite: 77, 411].

### 2. Sequential Bit Calculation (Behavioral)
* [cite_start]**Logic**: Calculates bits sequentially using optimized shift and add/subtract operations[cite: 81, 111].
* [cite_start]**Efficiency**: Uses only 1% of total logic elements[cite: 412, 419].

### 3. Fully Combinatorial
* [cite_start]**Logic**: A loop-unrolled architecture that computes the result "instantly" within one long combinational path[cite: 133, 134].
* [cite_start]**Trade-off**: Low $F_{max}$ (6.19 MHz) due to high propagation delay[cite: 414, 419].

### 4. Pipelined Architecture
* [cite_start]**Logic**: Converts the combinatorial path into a 32-stage pipeline[cite: 177, 265].
* [cite_start]**Throughput**: High throughput; capable of accepting one new input per clock cycle[cite: 415].

### 5. Structural Datapath & Controller (Optimal)
* [cite_start]**Logic**: Explicit separation of control logic (FSM) and datapath (Adder/Subtractor, Shift Registers)[cite: 273, 334].
* [cite_start]**Result**: Achieved the highest efficiency (0.7619 MHz/LE) and the best area-to-speed ratio[cite: 416, 417].



## 📊 Performance Comparison

| Architecture | Logic Elements (LE) | Max Frequency ($F_{max}$) | Latency (Cycles) |
| :--- | :--- | :--- | :--- |
| **Newton (Arch 1)** | [cite_start]4,920 (26%) [cite: 419] | [cite_start]2.42 MHz [cite: 419] | [cite_start]Variable [cite: 419] |
| **Sequential (Arch 2)** | [cite_start]255 (1%) [cite: 419] | [cite_start]163.19 MHz [cite: 419] | [cite_start]33 [cite: 419] |
| **Combinatorial (Arch 3)**| [cite_start]2,675 (14%) [cite: 419] | [cite_start]6.19 MHz [cite: 419] | [cite_start]Instant [cite: 419] |
| **Pipelined (Arch 4)** | [cite_start]3,352 (18%) [cite: 419] | [cite_start]132.94 MHz [cite: 419] | [cite_start]33 [cite: 419] |
| **Structural (Arch 5)** | [cite_start]**210 (1%)** [cite: 419] | [cite_start]**160.0 MHz** [cite: 419] | [cite_start]**33** [cite: 419] |

## 🛠️ Tools
* [cite_start]**HDL**: VHDL [cite: 4]
* [cite_start]**Synthesis**: Quartus II 64-Bit Version 13.0.1 Build 232 SP 1 [cite: 66]
* [cite_start]**Target Device**: Altera Cyclone II EP2C20F484C7 [cite: 66]

---
[cite_start]**Author**: Amirhossein Yousevand [cite: 6]  
[cite_start]**Date**: December 2025 [cite: 7]
