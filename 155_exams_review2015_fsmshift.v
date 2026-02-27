module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    reg [1:0] counter;
    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            shift_ena <= 1;
        end else if (shift_ena) begin
            counter <= counter + 1;
            if (counter == 3)
                shift_ena <= 0;
        end else
            counter <= 0;
    end
endmodule
