module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= 1;
        else
            if (train_valid) begin
                if (train_taken && state < 3)
                    state <= state + 1;
                else if (~train_taken && state > 0)
                    state <= state - 1;
                else
                    state <= state;
            end else
                state <= state;
    end
endmodule
