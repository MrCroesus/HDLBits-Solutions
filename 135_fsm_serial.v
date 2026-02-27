module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    reg [3:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                0: state <= ~in ? 1 : 0;
                1,2,3,4,5,6,7,8: state <= state + 1;
                9: state <= in ? 10 : 11;
                10: state <= ~in ? 1 : 0;
                11: state <= in ? 0 : 11;
            endcase
        end
    end
    
    assign done = state == 10;
endmodule
