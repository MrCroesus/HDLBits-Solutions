module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    reg [2:0] state;
    reg [1:0] count;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                0: state <= s ? 1 : 0;
                1,2,3: state <= state + 1;
                4: state <= 2;
            endcase
            if (state == 1 || state == 4) begin
                count <= w;
            end else begin
            	count <= w ? count + 1 : count;
            end
        end
    end
    
    assign z = (state == 4) && (count == 2);
endmodule
