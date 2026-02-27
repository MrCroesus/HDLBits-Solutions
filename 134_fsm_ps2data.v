module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    
    reg [1:0] state;

    // FSM from fsm_ps2
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
            out_bytes <= {out_bytes[15:0], in};
        end
    end

    // New: Datapath to store incoming bytes.
    
    assign done = state == 3;

endmodule
