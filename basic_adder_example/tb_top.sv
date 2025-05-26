`include "uvm_macros.svh"
import uvm_pkg::*;

// Include UVM component source files
`include "interface.sv"
`include "seq_item.sv"
`include "base_seq.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "env.sv"
`include "base_test.sv"

module tb_top;

  // Clock and reset signals
  logic clk = 0;
  logic reset;

  // Clock generation: 4 time units period
  always #2 clk = ~clk;

  // Reset generation
  initial begin
    reset = 1;
    #5;         // Hold reset for 5 time units
    reset = 0;
  end

  // Instantiate interface and connect clk, reset
  add_if vif(.clk(clk), .reset(reset));

  // Instantiate Device Under Test (DUT)
  adder DUT(
      .clk(vif.clk),
      .reset(vif.reset),
      .in1(vif.ip1),
      .in2(vif.ip2),
      .out(vif.out)
  );

  initial begin
    // Pass virtual interface handle into UVM config database for all components
    uvm_config_db#(virtual add_if)::set(uvm_root::get(), "*", "vif", vif);

    // Waveform dumping for waveform viewing and debugging
    $dumpfile("dump.vcd");
    $dumpvars();  // Dump variables

    #1000;  // Simulation runtime
    $finish;
  end

  // Start the UVM test
  initial begin
    run_test("base_test");
  end

endmodule
