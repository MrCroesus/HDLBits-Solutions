module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
   	
    wire [99:0] intermediate_cin;
    assign intermediate_cin[0] = cin;
    assign intermediate_cin[99:1] = cout[98:0];
    full_adder fa[99:0](a, b, intermediate_cin, cout, sum);
    
endmodule

module full_adder(
    input a, b, cin,
    output cout, sum
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule