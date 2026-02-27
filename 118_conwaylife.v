module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q );
    
    integer u, d, l, r;
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            for (integer i = 0; i < 16; i++) begin
                for (integer j = 0; j < 16; j++) begin
                    u = i == 0 ? 15 : i - 1;
                    d = i == 15 ? 0 : i + 1;
                    l = j == 0 ? 15 : j - 1;
                    r = j == 15 ? 0 : j + 1;
                    case(q[u*16+l] + q[u*16+j] + q[u*16+r] + q[i*16+l] + q[i*16+r] + q[d*16+l] + q[d*16+j] + q[d*16+r])
                        2: q[i*16+j] <= q[i*16+j];
                        3: q[i*16+j] <= 1;
                        default: q[i*16+j] <= 0;
                    endcase
                end
            end
    end
endmodule
