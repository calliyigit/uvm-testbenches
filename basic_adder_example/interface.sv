// Interface definition for the adder DUT
interface add_if(input logic clk, reset);

  // 8-bit input signals to the adder
  logic [7:0] ip1, ip2;

  // 9-bit output signal to accommodate overflow from 8-bit addition
  logic [8:0] out;

endinterface
