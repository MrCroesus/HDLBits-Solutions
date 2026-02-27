module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    reg state_reg = 0;
    always @(posedge clk) begin
        if (a == 1 && b == 1 && state_reg == 0) state_reg <= 1;
        else if (a == 0 && b == 0 && state_reg == 1) state_reg <= 0;
    end
    assign q = a ^ b ^ state;
    assign state = state_reg;
endmodule
