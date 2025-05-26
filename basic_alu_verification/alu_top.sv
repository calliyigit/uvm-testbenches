`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

// -------------------------------------------------------
// Include Files - all UVM components and interface
// -------------------------------------------------------
`include "alu_interface.sv"
`include "alu_seq_item.sv"
`include "alu_sequence.sv"
`include "alu_sequencer.sv"
`include "alu_driver.sv"
`include "alu_monitor.sv"
`include "alu_scoreboard.sv"
`include "alu_agent.sv"
`include "alu_env.sv"
`include "alu_test.sv"

module top;
    // -------------------------------------------------------
    // Signal declarations
    // -------------------------------------------------------

    logic  clock = 0;
    logic  reset;

    // Instantiate interface with clock and reset signals
    alu_interface intf(.clock(clock), .reset(reset));

    // Instantiate Device Under Test (DUT) and connect interface signals
    alu dut(
        .clock(intf.clock),
        .reset(intf.reset),
        .A(intf.a),
        .B(intf.b),
        .ALU_Sel(intf.op_code),
        .ALU_Out(intf.result),
        .CarryOut(intf.carry_out)
    );

    // Run UVM testbench with "alu_test"
    initial begin
        run_test("alu_test");
    end

    // Set virtual interface for UVM components through config DB
    initial begin
        uvm_config_db#(virtual alu_interface)::set(null, "*", "vif", intf);
    end

    // Generate clock signal: toggle every 2ns -> 250 MHz clock
    initial begin
        forever begin
            clock = ~clock;
            #2;
        end
    end

    // Apply reset at start of simulation
    initial begin
        reset = 1;
        #10;
        reset = 0;
    end

    // Timeout after 5000ns if simulation does not finish
    initial begin
        #5000;
        $display("Sorry run out of clock cycles!");
        $finish();
    end

    // VCD waveform dumping for debugging and waveform viewing
    initial begin   
        $dumpfile("d.vcd");
        $dumpvars();
    end
    
endmodule
