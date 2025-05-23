`timescale 1ns/1ns

// Include UVM macros and package
`include "uvm_macros.svh"
import uvm_pkg::*;

// Include all your UVM component source files
`include "dff_intf.sv"
`include "dff_seq_item.sv"
`include "dff_sequence.sv"
`include "dff_sequencer.sv"
`include "dff_driver.sv"
`include "dff_monitor.sv"
`include "dff_agent.sv"
`include "dff_scoreboard.sv"
`include "dff_env.sv"
`include "dff_test.sv"

// Top module for the testbench
module top;
    // Clock and reset signals
    logic clk = 0;
    logic rst = 1;

    // Generate clock with 20ns period (50MHz)
    always #10 clk = ~clk;

    // Deassert reset after 50ns
    initial begin
        #50;
        rst = 0;
    end

    // Instantiate the interface and connect clock and reset
    dff_intf intf(.clk(clk), .rst(rst));

    // VCD waveform dump setup for debugging
    initial begin
        $dumpfile("dump.vcd"); 
        $dumpvars(0, top); // Dump variables in the top scope and below
        #1000; 
        $finish(); // End simulation after 1000ns
    end

    // Set virtual interface handle in UVM config DB for all components (using wildcard "*")
    initial begin
        uvm_config_db#(virtual dff_intf)::set(null, "*", "vif", intf);
    end

    // Instantiate the Device Under Test (DUT) and connect ports to interface signals
    dff dut(
        .clk(intf.clk),
        .rst(intf.rst),
        .d(intf.d),
        .q(intf.q)
    );

    // Start UVM test
    initial begin
        run_test("dff_test");
    end

endmodule
