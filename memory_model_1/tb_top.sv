`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"
//-------------------------------------------------------------------------
//				www.verificationguide.com   testbench.sv
//-------------------------------------------------------------------------
//---------------------------------------------------------------
//including interfcae and testcase files
`include "mem_interface.sv"
`include "mem_seq_item.sv"
`include "mem_write_sequence.sv"
`include "mem_read_sequence.sv"
`include "mem_wr_rd_sequence.sv"
`include "mem_sequencer.sv"
`include "mem_driver.sv"
`include "mem_monitor.sv"
`include "mem_scoreboard.sv"
`include "mem_agent.sv"
`include "mem_env.sv"
`include "mem_base_test.sv"
`include "mem_wr_rd_test.sv"
//---------------------------------------------------------------

module tb_top;

  //---------------------------------------
  //clock and reset signal declaration
  //---------------------------------------
  bit clk = 0;
  bit reset;
  
  //---------------------------------------
  //clock generation
  //---------------------------------------
  always #5 clk = ~clk;
  
  //---------------------------------------
  //reset Generation
  //---------------------------------------
  initial begin
    reset = 1;
    #5;
    reset = 0;
  end
  
  //---------------------------------------
  //interface instance
  //---------------------------------------
  mem_interface intf(.clk(clk),.reset(reset));
  
  //---------------------------------------
  //DUT instance
  //---------------------------------------
  memory DUT (
    .clk(intf.clk),
    .reset(intf.reset),
    .addr(intf.addr),
    .wr_en(intf.wr_en),
    .rd_en(intf.rd_en),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
   );
  
  //---------------------------------------
  //passing the interface handle to lower heirarchy using set method 
  //and enabling the wave dump
  //---------------------------------------
  initial begin 
    uvm_config_db#(virtual mem_interface)::set(uvm_root::get(),"*","vif",intf);
  end

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars();
    
  end
  
  //---------------------------------------
  //calling test
  //---------------------------------------
  initial begin 
    run_test("mem_wr_rd_test");
  end
  
endmodule