module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] prev_in;
    
    always @(posedge clk) begin
        prev_in <= in;
        if (reset)
            out <= 0;
        else if (~in & (prev_in ^ in))
            out <= out | (~in & (prev_in ^ in));
        else
            out <= out;
    end
endmodule
