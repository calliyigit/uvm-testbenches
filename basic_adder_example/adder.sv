module adder(
    input  logic          clk, reset,    // Clock and asynchronous reset signals
    input  logic [7:0]    in1, in2,      // 8-bit input operands
    output logic [8:0]    out            // 9-bit output to hold the sum (handles overflow)
    );

    // Sequential logic block triggered on rising edge of clk or reset
    always_ff @(posedge clk or posedge reset) begin 
        if(reset) 
            out <= 0;                   // If reset is high, clear the output
        else 
            out <= in1 + in2;           // Otherwise, compute the sum of in1 and in2
    end
endmodule
