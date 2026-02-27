module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    
    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                0: state <= ~w ? 1 : 0;
                1: state <= ~w ? 2 : 3;
                2: state <= ~w ? 4 : 3;
                3: state <= ~w ? 5 : 0;
                4: state <= ~w ? 4 : 3;
                5: state <= ~w ? 2 : 3;
            endcase
        end
    end
    
    assign z = state >= 4;
endmodule
