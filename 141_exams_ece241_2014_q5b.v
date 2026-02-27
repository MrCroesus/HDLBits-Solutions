module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    reg [1:0] state;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else begin
            if (state == 2'b01) state <= x ? 2'b10 : 2'b01;
            if (state == 2'b10) state <= state;
        end
    end
    
    assign z = (state == 2'b01 && x) | (state == 2'b10 && ~x);
endmodule
