module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout;
    wire [15:0] sum_tophalf_cin0, sum_tophalf_cin1;
    
    add16 adder1(a[15:0], b[15:0], 1'b0, sum[15:0], cout);
    add16 adder2a(a[31:16], b[31:16], 1'b0, sum_tophalf_cin0, 1'b0);
    add16 adder2b(a[31:16], b[31:16], 1'b1, sum_tophalf_cin1, 1'b0);
    
    assign sum[31:16] = cout ? sum_tophalf_cin1 : sum_tophalf_cin0;
endmodule
