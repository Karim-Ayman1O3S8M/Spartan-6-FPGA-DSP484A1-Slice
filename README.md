# Project Overview: Spartan6 - DSP48A1 in Verilog

## Table of Contents
- [Project Overview: Spartan6 - DSP48A1 in Verilog](#project-overview-spartan6---dsp48a1-in-verilog)
  - [Table of Contents](#table-of-contents)
  - [Outline](#outline)
  - [Design Specifications](#design-specifications)
    - [Parameters and Attributes](#parameters-and-attributes)
    - [Data Ports](#data-ports)
    - [Control Input Ports](#control-input-ports)
    - [Clock Enable Input Ports](#clock-enable-input-ports)
    - [Reset Input Ports](#reset-input-ports)
    - [Cascade Ports](#cascade-ports)
      - [The overall block diagram with the hierarchy of testing anotated below](#the-overall-block-diagram-with-the-hierarchy-of-testing-anotated-below)
  - [Results](#results)
    - [Waveform / Transcript Snippets](#waveform--transcript-snippets)
      - [Synchronous Reset](#synchronous-reset)
      - [Layer 1 Testing (Pre-adder/Subtractor)](#layer-1-testing-pre-addersubtractor)
      - [Layer 2 Testing (Multiplier Operation)](#layer-2-testing-multiplier-operation)
    - [Synthesis \& Elaboration](#synthesis--elaboration)
    - [Implementation \& Utilization Report](#implementation--utilization-report)
    - [Messages Tab](#messages-tab)
    - [Configuration](#configuration)
 

## Outline
- This project involves designing and implementing the DSP48A1 slice of the Spartan-6 FPGA using Verilog. The DSP48A1 slice is a critical component for digital signal processing, enabling high-performance mathematical computations essential in various applications. This documentation outlines the design specifications, implementation details, simulation results, and references used.
  
* Tools
    - Questasim
    - Xilinix Vivado  


## Design Specifications

The design of the DSP48A1 slice in the Spartan-6 FPGA involves several critical components and configurations, outlined as follows:

### Parameters and Attributes
- **Pipeline Registers**: Parameters such as `A0REG`, `A1REG`, `B0REG`, `B1REG`, `CREG`, `DREG`, `MREG`, `PREG`, `CARRYINREG`, `CARRYOUTREG`, and `OPMODEREG` define the number of pipeline stages, typically defaulting to 1 (registered).
- **Carry Cascade**: The `CARRYINSEL` attribute determines the source of the carry-in, defaulting to `OPMODE5`.
- **Input Routing**: `B_INPUT` controls whether the B input is directly from the port or cascaded from an adjacent slice.
- **Reset Type**: The `RSTTYPE` attribute selects synchronous or asynchronous resets, defaulting to synchronous.

### Data Ports
- **`A`, `B`, `D` (18-bit)**: Data inputs for multiplication and pre/post addition/subtraction.
- **`C` (48-bit)**: Data input to the post-adder/subtracter.
- **`CARRYIN`**: Input for carry-in to the adder/subtracter.
- **`M` (36-bit)**: Buffered multiplier output.
- **`P` (48-bit)**: Primary output from the adder/subtracter.
- **`CARRYOUT`, `CARRYOUTF`**: Cascade and logic carry-out signals.

### Control Input Ports
- **`CLK`**: Clock signal.
- **`OPMODE`**: Control signal for arithmetic operation selection.

### Clock Enable Input Ports
- **`CEA`, `CEB`, `CEC`, `CECARRYIN`, `CED`, `CEM`, `CEOPMODE`, `CEP`**: Clock enable signals for various registers.

### Reset Input Ports
-  `RSTA`, `RSTB`, `RSTC`, `RSTCARRYIN`, `RSTD`, `RSTM`, `RSTOPMODE`, `RSTP`: Active-high reset signals, either synchronous or asynchronous.

### Cascade Ports
- `BCOUT`, `PCIN`, `PCOUT`: Ports for cascading data between adjacent DSP48A1 slices.

This comprehensive specification ensures the DSP48A1 slice is optimally configured for high-performance digital signal processing applications within the Spartan-6 FPGA.
For more info, refer to the original doc [Spartan-6 FPGA DSP484A1 Slice (User Guide)](https://docs.amd.com/v/u/en-US/ug389)

#### The overall block diagram with the hierarchy of testing anotated below 
![Block Diagram](Results/Block%20Diagram.png)
>[!NOTE] 
>>Layer 1 & 2 are fully tested using self-checking testbench accounting for the pipeline timing tests but Layer 3 has been tested sperately & is currently under test  


## Results
### Waveform / Transcript Snippets
#### Synchronous Reset
* [Reset test](/Results/Rest%20operation.png) 
#### Layer 1 Testing (Pre-adder/Subtractor)
* [BCOUT_test](/Results/Pipelining_test.png)
#### Layer 2 Testing (Multiplier Operation)
* [M_test](/Results/Multiplier_operation.png)

### Synthesis & Elaboration
* [Synthesis](/Results/Synthesis.png)
* [Elaboration](/Results/Elaboration.png)

### Implementation & Utilization Report
* [Implementation](/Results/Implementation.png)
* [Utlization Report](/Results/Utilization%20Report.png)
* [Utilization Summary](/Results/Utilization%20Summary.png)

### Messages Tab
* [Elaboration Message](/Results/Elaboration%20message.png)
* [Synthesis Message](/Results/Synthesis%20Message.png)
### Configuration
![DSP Configuration](/Results/DSP_configuration.png)
