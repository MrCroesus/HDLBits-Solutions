module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [2:0] intermediate_cout;
    
    bcd_fadd fa1(a[3:0], b[3:0], cin, intermediate_cout[0], sum[3:0]);
    bcd_fadd fa2(a[7:4], b[7:4], intermediate_cout[0], intermediate_cout[1], sum[7:4]);
    bcd_fadd fa3(a[11:8], b[11:8], intermediate_cout[1], intermediate_cout[2], sum[11:8]);
    bcd_fadd fa4(a[15:12], b[15:12], intermediate_cout[2], cout, sum[15:12]);
endmodule
