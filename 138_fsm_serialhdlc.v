module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    reg [3:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                0,1,2,3,4: state <= in ? state + 1 : 0;
                5: state <= in ? state + 1 : 8;
                6: state <= in ? state + 1 : 9;
                7: state <= in ? 7 : 0;
                8, 9: state <= in ? 1 : 0;
            endcase
        end
    end
                    
   	assign disc = state == 8;
    assign flag = state == 9;
    assign err = state == 7;
endmodule
