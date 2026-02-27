module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    reg [2:0] state;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin
                    if (~ground) begin
                        state <= 3'b010;
                    end else if (dig) begin
                        state <= 3'b100;
                    end else if (bump_left) begin
                        state <= 3'b001;
                    end
                end
                3'b001: begin
                    if (~ground) begin
                        state <= 3'b011;
                    end else if (dig) begin
                        state <= 3'b101;
                    end else if (bump_right) begin
                        state <= 3'b000;
                    end
                end
                3'b010: begin
                    state <= ground ? 3'b000 : 3'b010;
                end
                3'b011: begin
                    state <= ground ? 3'b001 : 3'b011;
                end
                3'b100: begin
                    state <= ~ground ? 3'b010 : 3'b100;
                end
                3'b101: begin
                    state <= ~ground ? 3'b011 : 3'b101;
                end
            endcase
        end
    end
    
    assign walk_left = ~state[0] & ~state[1] & ~state[2];
    assign walk_right = state[0] & ~state[1] & ~state[2];
    assign aaah = state[1];
    assign digging = state[2];

endmodule
