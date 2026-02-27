module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    reg [3:0] state;
    reg [4:0] cycle;

    // Modify FSM and datapath from Fsm_serialdata
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            cycle <= 1;
        end else begin
            case (state)
                0: begin
                    state <= ~in ? 1 : 0;
                    out_byte <= 0;
                end
                1,2,3,4,5,6,7,8: begin
                    state <= state + 1;
                    out_byte <= {in, out_byte[7:1]};
                end
                9: state <= state + 1;
                10: state <= in & odd ? 11 : in ? 0 : 12;
                11: state <= ~in ? 1 : 0;
                12: state <= in ? 0 : 12;
            endcase
            cycle <= cycle + 1;
        end
    end

    // New: Add parity checking.
    wire parity_reset;
    reg odd;
    assign parity_reset = (state == 0) || (state == 11);
    parity(clk, parity_reset, in, odd);
    
    assign done = state == 11;

endmodule
