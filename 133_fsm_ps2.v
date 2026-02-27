module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    
    reg [1:0] state;

    // State transition logic (combinational)

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                0: state <= in[3] ? 1 : 0;
                1: state <= 2;
                2: state <= 3;
                3: state <= in[3] ? 1 : 0;
            endcase
        end
    end
 
    // Output logic
    assign done = state == 3;

endmodule
