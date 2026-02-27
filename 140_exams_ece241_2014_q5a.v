module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    reg [1:0] state;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 0;
        end else begin
            case (state)
                0: state <= x ? 1 : 0;
                1, 2, 3: state <= x ? 3 : 2;
            endcase
        end
    end
    
    assign z = (state == 1) || (state == 2);
endmodule
