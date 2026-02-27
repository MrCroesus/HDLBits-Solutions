module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
); //
    reg [9:0] next_state;

    // You may use these parameters to access state bits using e.g., state[B2] instead of state[6].
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9;
    
    always @(*) begin
        if (d == 0) begin
            next_state = (state[S] << S) | (state[S1] << S) | (state[S11] << S110) | (state[S110] << S);
        end else if (d == 1) begin
            next_state = (state[S] << S1) | (state[S1] << S11) | (state[S11] << S11) | (state[S110] << B0);
        end
        if (done_counting) begin
            next_state = next_state | (state[Count] << (Count + 1));
        end else begin
            next_state = next_state | (state[Count] << Count);
        end
        if (ack) begin
            next_state = next_state | (state[Wait] << S);
        end else begin
            next_state = next_state | (state[Wait] << Wait);
        end
        next_state = next_state | (state[B3:B0] << (B0 + 1));
    end

    assign B3_next = next_state[B3];
    assign S_next = next_state[S];
    assign S1_next = next_state[S1];
    assign Count_next = next_state[Count];
    assign Wait_next = next_state[Wait];
    assign done = state[Wait];
    assign counting = state[Count];
    assign shift_ena = |state[B3:B0];
    // etc.

endmodule
