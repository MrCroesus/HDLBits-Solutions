module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg reg1, reg2, reg3;
    
    always @(posedge clk) begin
        if (~resetn) begin
            reg1 <= 0;
        	reg2 <= 0;
        	reg3 <= 0;
            out <= 0;
        end else begin
            reg1 <= in;
        	reg2 <= reg1;
        	reg3 <= reg2;
        	out <= reg3;
        end
    end
endmodule
