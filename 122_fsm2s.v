module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
    end

    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if (reset) begin
            state <= OFF;
        end else begin
            case(state)
                ON: state <= k ? OFF : ON;
                OFF: state <= j ? ON : OFF;
            endcase
        end
    end

    // Output logic
    assign out = (state == ON);

endmodule
