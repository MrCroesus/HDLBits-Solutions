module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    reg [3:0] bits = 0;
    always @(posedge clk) begin
        if (reset) begin
            bits <= 0;
            start_shifting <= 0;
        end else begin
            bits <= {bits[2:0], data};
            if (bits[2:0] == 3'b110 && data) begin
                start_shifting <= 1;
            end
        end
    end
endmodule
