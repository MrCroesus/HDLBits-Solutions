module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    reg [3:0] state;

    // Use FSM from Fsm_serial
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            if (state == 0) begin
                state <= ~in ? 1 : 0;
                out_byte <= 0;
            end else if (state >= 1 && state < 9) begin
                state <= state + 1;
                out_byte <= {in, out_byte[7:1]};
            end else if (state == 9) begin
                state <= in ? 10 : 11;
            end else if (state == 10) begin
                state <= ~in ? 1 : 0;
            end else if (state == 11) begin
                state <= in ? 0 : 11;
            end
        end
    end

    // New: Datapath to latch input bits.
    assign done = state == 10;

endmodule
