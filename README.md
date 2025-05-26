# ALU UVM Testbench

This repository contains a UVM (Universal Verification Methodology) testbench for a simple Arithmetic Logic Unit (ALU) design. The testbench is developed as part of my learning journey in functional verification and SystemVerilog UVM methodology.

## 📚 Source and Credits

This testbench is inspired by and developed following the tutorial video:

🔗 [https://www.youtube.com/watch?v=2026Ei1wGTU](https://www.youtube.com/watch?v=2026Ei1wGTU)

## What You Will Learn

- The basic structure of a UVM testbench including environment, agent, driver, monitor, sequencer, scoreboard, and test.
- How to use virtual interfaces and UVM configuration database (`uvm_config_db`) to connect DUT signals with testbench components.
- How to implement sequences and sequence items to drive stimulus.
- How to implement a scoreboard for result checking.
- Handling synchronization and stimulus generation for an ALU module with basic operations.
- Running the testbench with a simple ALU RTL design.

## Repository Contents

- `alu_design.sv` — The Device Under Test (Arithmetic Logic Unit RTL)
- `alu_interface.sv` — Virtual interface for connecting DUT signals
- `alu_seq_item.sv` — Sequence item class defining stimulus transactions
- `alu_sequence.sv` — Sequence class generating stimulus items
- `alu_sequencer.sv` — Sequencer to arbitrate sequence items
- `alu_driver.sv` — Driver applying stimulus to DUT via interface
- `alu_monitor.sv` — Monitor observing DUT signals and forwarding transactions
- `alu_agent.sv` — Agent grouping driver, monitor, and sequencer
- `alu_scoreboard.sv` — Scoreboard for checking ALU output correctness
- `alu_env.sv` — Environment connecting agents and scoreboard
- `alu_test.sv` — Top-level test class starting the environment and sequences
- `alu_top.sv` — Top-level testbench module instantiating DUT, interface, and launching UVM test

## Online Simulation

You can run and experiment with this UVM testbench directly on [EDA Playground](https://edaplayground.com/x/pcrp) (example link).

## Disclaimer

This repository is for **educational purposes only**. The original inspiration and learning material belong to the author of the YouTube tutorial linked above.
