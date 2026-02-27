module top_module (
    input clk,
    input in, 
    output out);
    reg q = 0;
    always @(posedge clk) begin
        q <= in ^ q;
    end
    assign out = q;
endmodule
