# DFF UVM Testbench

This repository contains a UVM (Universal Verification Methodology) testbench for a simple synchronous D Flip-Flop (DFF) design. The testbench is implemented as part of my learning journey in functional verification and SystemVerilog UVM methodology.

## 📚 Source and Credits

This testbench is inspired by and developed following the tutorial video:

🔗 [https://www.youtube.com/watch?v=FEP38TDgc7I&t=3s](https://www.youtube.com/watch?v=FEP38TDgc7I&t=3s)

## What You Will Learn

- The basic structure of a UVM testbench including environment, agent, driver, monitor, sequencer, scoreboard, and test.
- How to use virtual interfaces and UVM configuration database (`uvm_config_db`) for connecting DUT signals with the testbench components.
- How to implement a simple sequence and sequence item to drive stimulus.
- Basic coverage and scoreboard concepts (can be extended).
- Running the testbench with a simple synchronous reset D Flip-Flop module.

## Repository Contents

- `dff.sv` — The Device Under Test (D Flip-Flop RTL)
- `dff_intf.sv` — Virtual interface for connecting DUT signals
- `dff_seq_item.sv` — Sequence item class for stimulus
- `dff_sequence.sv` — Sequence class generating stimulus items
- `dff_sequencer.sv` — Sequencer to arbitrate sequence items
- `dff_driver.sv` — Driver applying stimulus to DUT via interface
- `dff_monitor.sv` — Monitor observing DUT outputs and forwarding data
- `dff_agent.sv` — Agent grouping driver, monitor, and sequencer
- `dff_scoreboard.sv` — Scoreboard for checking DUT behavior (currently collects transactions)
- `dff_env.sv` — Environment connecting agents and scoreboard
- `dff_test.sv` — Top-level test class starting the environment and sequence
- `top.sv` — Top-level testbench module instantiating DUT, interface, and launching UVM test

## Online Simulation

You can run and experiment with this UVM testbench directly on [EDA Playground](https://edaplayground.com/x/rrKa).

## Disclaimer

This repository is for **educational purposes only**. The original inspiration and learning material belong to the author of the YouTube tutorial linked above.
