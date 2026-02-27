module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    reg state, next_state;

    always @(*) begin
        // State transition logic
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state = 0;
        end else begin
            case (state)
                0: next_state = bump_left ? 1 : 0;
                1: next_state = bump_right ? 0 : 1;
            endcase
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (state == 0);
    assign walk_right = (state == 1);

endmodule
