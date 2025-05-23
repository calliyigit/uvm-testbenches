module dff (
    input logic clk,    // Clock input
    input logic rst,    // Synchronous reset input (active high)
    input logic d,      // Data input
    output logic q      // Output
);

    // Synchronous reset and data sampling on rising clock edge
    always_ff @(posedge clk) begin
        if (rst) begin
            q <= 0;     // Reset output to 0 when reset is asserted
        end
        else begin
            q <= d;     // Otherwise, sample data input to output
        end
    end

endmodule
