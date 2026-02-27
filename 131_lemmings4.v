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
    
    reg [3:0] state;
    reg [31:0] counter;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 4'b0000;
            counter <= 0;
        end else begin
            case (state)
                4'b0000: begin
                    if (~ground) begin
                        state <= 4'b0010;
                    end else if (dig) begin
                        state <= 4'b0100;
                    end else if (bump_left) begin
                        state <= 4'b0001;
                    end
                end
                4'b0001: begin
                    if (~ground) begin
                        state <= 4'b0011;
                    end else if (dig) begin
                        state <= 4'b0101;
                    end else if (bump_right) begin
                        state <= 4'b0000;
                    end
                end
                4'b0010: begin
                    if (ground) begin
                        state <= counter >= 20 ? 4'b1000 : 4'b0000;
                        counter <= 0;
                    end else begin
                        state <= 4'b0010;
                        counter <= counter + 1;
                    end
                end
                4'b0011: begin
					if (ground) begin
                        state <= counter >= 20 ? 4'b1001 : 4'b0001;
                        counter <= 0;
                    end else begin
                        state <= 4'b0011;
                        counter <= counter + 1;
                    end
                end
                4'b0100: begin
                    state <= ground ? 4'b0100 : 4'b0010;
                end
                4'b0101: begin
                    state <= ground ? 4'b0101 : 4'b0011;
                end
            endcase
        end
    end
    
    assign walk_left = ~state[0] & ~state[1] & ~state[2] & ~state[3];
    assign walk_right = state[0] & ~state[1] & ~state[2] & ~state[3];
    assign aaah = state[1] & ~state[3];
    assign digging = state[2] & ~state[1] & ~state[3];

endmodule
