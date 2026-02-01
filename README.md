# Square Root Computing Architectures in VHDL

This repository presents the design, implementation, and evaluation of **five different square root computing architectures** for FPGA platforms using **VHDL**. The architectures explore multiple design paradigms—including iterative, combinational, pipelined, and structural approaches—and are compared in terms of **area, frequency, latency, and efficiency**.

## 📌 Overview

Computing square roots efficiently is a common requirement in digital signal processing and hardware accelerators. This project investigates several hardware architectures for computing the **integer square root** of an unsigned input, highlighting the trade-offs between:

- Hardware resource utilization  
- Maximum operating frequency  
- Latency and throughput  
- Deterministic vs. input-dependent execution time  

All designs are parameterized and synthesizable, making them suitable for FPGA-based implementations.

---

## 🧠 Implemented Architectures

### Architecture 1 – Newton Method (Iterative)
- Based on the Newton–Raphson method  
- Requires division operations  
- Input-dependent latency  
- High area cost and low maximum operating frequency  

### Architecture 2 – Shift-Based Iterative Algorithm
- Computes one result bit per clock cycle  
- Uses only shift and add/subtract operations  
- Fixed latency: **33 clock cycles**  
- Very area-efficient and high-frequency design  

### Architecture 3 – Fully Combinational
- Instantaneous square root computation  
- High combinational complexity  
- Low maximum operating frequency  
- Suitable when zero latency is required  

### Architecture 4 – Pipelined Architecture
- Pipelined version of the combinational algorithm  
- Accepts one new input per clock cycle after pipeline fill  
- Fixed latency: **33 clock cycles**  
- Increased area due to register usage  

### Architecture 5 – Structural Datapath + Controller
- Modular datapath and FSM-based controller  
- Uses shift registers, adder/subtractor, and control logic  
- Fixed latency: **33 clock cycles**  
- Best balance between area, speed, and determinism  

---

## 📊 Results Summary

| Architecture | Logic Elements | Fmax (MHz) | Clock Cycles |
|-------------|---------------|-----------|--------------|
| Architecture 1 (Newton) | 4,920 (26%) | 2.42 | Variable |
| Architecture 2 | 255 (1%) | 163.19 | 33 |
| Architecture 3 | 2,675 (14%) | 6.19* | Instant |
| Architecture 4 | 3,352 (18%) | 132.94 | 33 |
| Architecture 5 | 210 (1%) | 160.00 | 33 |

\* Maximum frequency for Architecture 3 was obtained by placing the combinational logic between two registers.

---

## 📈 Efficiency Comparison
Efficiency = Fmax / Total Logic Elements

Architecture 5 achieves the highest efficiency, followed closely by Architecture 2, making them the most suitable choices for FPGA-based square root computation.


---

## 📄 Documentation

A detailed technical report describing the algorithms, state machines, VHDL implementations, synthesis results, and performance comparisons is included:

- [Project Report](report.pdf).
  
---

## 👤 Author

**Amirhossein Yousefvand**  



