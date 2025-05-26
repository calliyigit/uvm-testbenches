interface alu_interface(input logic clock, reset);
  
    //Input A and B
    logic [7:0] a;
  	logic [7:0] b;

    //ALU_Sel
    logic [3:0] op_code;

    logic [7:0] result;
    logic       carry_out;
    
endinterface