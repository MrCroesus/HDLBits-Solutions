module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    reg [1:0] state;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state = 2'b10;
        end else begin
            case (state[0])
                0: state[0] <= bump_left & (state[1] & ground) ? 1 : 0;
                1: state[0] <= bump_right & (state[1] & ground) ? 0 : 1;
            endcase
            state[1] <= ground;
        end
    end
    
    assign walk_left = ~state[0] & state[1];
    assign walk_right = state[0] & state[1];
    assign aaah = ~state[1];
        
endmodule
