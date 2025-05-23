interface dff_intf(input logic clk, rst);
    logic d;  // D input signal (data input to the flip-flop)
    logic q;  // Q output signal (data output from the flip-flop)
endinterface