module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [100:0] intermediate_cin;
    assign intermediate_cin[0] = cin;
    assign cout = intermediate_cin[100];
    
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin:generator
            bcd_fadd fa(a[i * 4 + 3: i * 4], b[i * 4 + 3: i * 4], intermediate_cin[i], intermediate_cin[i + 1], sum[i * 4 + 3:i * 4]);
        end
    endgenerate
endmodule
