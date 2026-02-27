module top_module(
    input clk,
    input in,
    input reset,
    output out); //
    reg [1:0] state;

    // State transition logic

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                0: state <= in ? 1 : 0;
                1: state <= in ? 1 : 2;
                2: state <= in ? 3 : 0;
                3: state <= in ? 1 : 2;
            endcase
        end
    end

    // Output logic
    assign out = (state == 3);

endmodule
