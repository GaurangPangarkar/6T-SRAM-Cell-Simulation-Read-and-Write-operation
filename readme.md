# Simulation of 6T SRAM Cell Read and Write Operation

## Project Overview

Static Random Access Memory (SRAM) is a high-speed semiconductor memory widely used in processor caches, register files, embedded systems, and other digital applications. This project focuses on understanding and simulating the read, write, and hold operations of a conventional Six-Transistor (6T) SRAM cell using Verilog HDL and the Vivado simulation environment.

The project explains the architecture and working principle of a 6T SRAM cell and examines a behavioral Verilog model and its testbench to demonstrate the functional sequence of writing and reading binary data.

## Objectives

- Study the architecture and working principle of a conventional 6T SRAM cell.
- Understand the functions of the six MOSFETs used in the SRAM storage cell.
- Analyze the hold, read, and write operations.
- Implement and examine a behavioral SRAM model using Verilog HDL.
- Develop a testbench to apply read and write operations.
- Observe the digital waveforms and compare the expected behavior with the supplied simulation evidence.
- Understand the limitations of behavioral simulation and identify opportunities for transistor-level analysis.

## 6T SRAM Cell Architecture

A conventional 6T SRAM cell consists of six MOSFETs:

- **Four transistors (M1–M4):** Form two cross-coupled CMOS inverters that store one bit of data.
- **Two transistors (M5–M6):** Act as access transistors that connect the internal storage nodes to the complementary bit lines.

The cell uses the following signals:

| Signal | Description |
|---|---|
| `WL` | Word line that enables access to the cell |
| `WE` | Write enable used by the behavioral model |
| `BL` | Bit line |
| `BL_bar` | Complementary bit line |
| `stored_bit` | Internal register representing the stored data |

The two complementary storage nodes, Q and Q̅, maintain opposite logic values. The stored data is retained as long as the supply voltage is present.

## Working Principle

### 1. Write Operation

During a write operation, `WE` is set to logic 1 and the word line is activated. The testbench drives the bit lines with complementary values to specify the data to be stored.

- **Write 1:** `BL = 1`, `BL_bar = 0`
- **Write 0:** `BL = 0`, `BL_bar = 1`

In the supplied behavioral model, the value on `BL` is captured at the rising edge of `WL` when `WE = 1`.

### 2. Read Operation

During a read operation, `WE` is set to logic 0 and `WL` is activated. The external bit-line drivers are disabled, allowing the behavioral model to drive the output lines.

- When the stored bit is 1, `BL = 1` and `BL_bar = 0`.
- When the stored bit is 0, `BL = 0` and `BL_bar = 1`.

### 3. Hold Operation

During the hold operation, `WL` remains low. The cell does not drive the bit lines, and the stored value is expected to remain unchanged in the behavioral model.

## Verilog Implementation

The behavioral design uses a register to represent the stored bit and bidirectional, tri-state bit lines to model data transfer during read and write operations.

The design module is named `sram_6t_cell`, and the testbench is named `tb_sram_6t`.

The behavioral implementation includes:

- A stored-bit register initialized to logic 0.
- An edge-triggered write operation using `always @(posedge WL)`.
- Conditional read logic using continuous assignments.
- High-impedance (`1'bz`) outputs when the cell is not driving the bit lines.
- Complementary output generation through `BL` and `BL_bar`.

**Important:** This is a behavioral Verilog model of SRAM functionality. It does not instantiate the six MOSFETs of a physical SRAM cell and does not model actual transistor-level electrical behavior.

## Testbench and Verification

The testbench applies the following sequence of operations:

| Test | Operation | Expected Result |
|---|---|---|
| 1 | Write logic 1 | Stored bit becomes 1 |
| 2 | Hold | Stored bit remains 1 |
| 3 | Read logic 1 | `BL = 1`, `BL_bar = 0` |
| 4 | Write logic 0 | Stored bit becomes 0 |
| 5 | Read logic 0 | `BL = 0`, `BL_bar = 1` |

The supplied testbench uses timed stimulus and is expected to complete at 210 ns.

The waveform screenshots provided with the project reference material show read outputs consistent with the expected write-1, hold, read-1, write-0, and read-0 sequence. However, the internal stored-bit waveform and compilation log were not available for complete independent verification.

## Simulation Using Vivado

The general simulation workflow is:

1. Open the project in AMD Xilinx Vivado.
2. Add the SRAM Verilog module as a design source.
3. Add the testbench as a simulation source.
4. Select the testbench as the simulation top module.
5. Run **Behavioral Simulation**.
6. Observe the waveforms of `WL`, `WE`, `BL`, `BL_bar`, and the testbench control signals.
7. Where accessible, add `stored_bit` from the instantiated DUT (`uut`) to the waveform viewer.
8. Compare the observed read and write behavior with the expected test sequence.

The testbench listing in the report requires a closing `endmodule` statement if it is absent from the actual source file.

## Simulation Results

The supplied waveform screenshots are consistent with the expected functional behavior:

- The bit lines are driven to complementary values during write operations.
- The read-1 window shows outputs consistent with a stored logic 1.
- The read-0 window shows outputs consistent with a stored logic 0.
- The testbench disables its external bit-line drivers during read operations.

These observations support the intended functional sequence, but they do not establish complete verification because the internal storage register trace and compilation log were not supplied.

No transistor-level simulation was performed as part of the reported work.

## Advantages of SRAM

- High-speed data access.
- No periodic refresh required while powered.
- Non-destructive read operation in a conventional 6T cell.
- Suitable for cache memories, register files, and on-chip buffers.

## Limitations

- Higher cell area compared with DRAM.
- Higher cost per stored bit in typical implementations.
- Data is lost when power is removed.
- Transistor sizing must balance read stability and write ability.
- Behavioral simulation cannot determine actual power consumption, current, delay, or noise margins.

## Future Scope

The project can be extended in the following directions:

- Perform transistor-level simulation using LTspice or Cadence Virtuoso.
- Study read stability, write margin, and static noise margin.
- Analyze dynamic power, leakage power, and access delay.
- Investigate the effects of transistor sizing and supply-voltage variations.
- Extend the single-cell model into a small SRAM array with address decoding.
- Add self-checking assertions or testbench tasks to automate functional verification.

## Applications

6T SRAM technology is commonly used in:

- Processor cache memories (L1, L2, and L3).
- Register files and on-chip buffers.
- Embedded systems and system-on-chip designs.
- FPGA-related memory structures.
- High-speed digital and signal-processing systems.

## Technologies Used

- **Hardware Description Language:** Verilog HDL
- **Simulation Environment:** AMD Xilinx Vivado
- **Design Type:** Behavioral SRAM model
- **Verification Method:** Testbench-driven functional simulation and waveform inspection

## Conclusion

This project studies the structure and operation of a conventional 6T SRAM cell and examines its read, write, and hold behavior using a behavioral Verilog model. The testbench provides a sequence for writing logic 1, retaining the value, reading logic 1, writing logic 0, and reading logic 0.

The supplied waveform evidence is consistent with the intended functional behavior. The project also highlights the distinction between behavioral modeling and transistor-level simulation, establishing a foundation for further investigation of SRAM timing, power, stability, and circuit design.

---

**Project Title:** Simulation of 6T SRAM Cell Read and Write Operation  
**Department:** Electronics and Telecommunication Engineering  
**Institution:** Modern Education Society's Wadia College of Engineering, Pune  
**Academic Year:** 2026–2027
