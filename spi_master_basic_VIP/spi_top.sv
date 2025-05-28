`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

// -------------------------------------------------------
//Include Files
// -------------------------------------------------------
`include "spi_interface.sv"
`include "spi_seq_item.sv"
`include "spi_sequence.sv"
`include "spi_sequencer.sv"
`include "spi_driver.sv"
`include "spi_monitor.sv"
`include "spi_scoreboard.sv"
`include "spi_agent.sv"
`include "spi_env.sv"
`include "spi_test.sv"

module top;
    // -------------------------------------------------------
    //Instantiations
    // -------------------------------------------------------


    logic  clock = 0;
  	logic  reset;

    spi_interface vif(clock, reset);

    spi_master dut(
        .mclk(vif.mclk),
        .reset(vif.reset),
        .load(vif.load),
        .miso(vif.miso),
        .start(vif.start),
        .read(vif.read),
        .data_in(vif.data_in),
        .data_out(vif.data_out),
        .mosi(vif.mosi),
        .cs(vif.cs_n),
        .sclk(vif.sclk)
    );

    initial begin
        run_test("spi_test");
    end

    initial begin
        uvm_config_db#(virtual spi_interface)::set(null,"*","vif", vif);
    end

    always #2 clock = ~clock;
  
  	initial begin
       reset = 0;
       #5;
       reset = 1;
    end

    initial begin   
        $dumpfile("d.vcd");
        $dumpvars();
    end
    
endmodule