module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg signed [63:0] q); 
    always @(posedge clk) begin
        if (load)
            q <= data;
        else if (ena)
            case(amount)
                0: q <= q <<< 1;
                1: q <= q <<< 8;
                2: q <= q >>> 1;
                3: q <= q >>> 8;
            endcase
        else
            q <= q;
    end
endmodule
