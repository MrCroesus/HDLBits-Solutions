module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    wire [511:0] l, r;
    assign l = {1'b0, q[511:1]};
    assign r = {q[510:0], 1'b0};
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= (l & (q ^ r)) | (~l & (q | r));
    end
endmodule
