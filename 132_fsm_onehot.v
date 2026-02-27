module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    always @(*) begin
        if (in) begin
            next_state = (state[6:0] << 1) | (state[7] << 7) | (state[8] << 1) | (state[9] << 1);
        end else begin
            next_state = (|state[4:0]) | (state[5] << 8) | (state[6] << 9) | (|state[9:7]);
        end
    end
    
    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];
    
endmodule
