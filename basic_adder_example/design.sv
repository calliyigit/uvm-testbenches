module design(
    input  logic clk, reset,
    input  logic [7:0] in1, in2,
    output logic [8:0] out
);
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            out <= 0;
        end
        else begin
            out <= in1 + in2;
        end
    end
    
endmodule