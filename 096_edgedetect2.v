
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] prev_in = 0;
    always @(posedge clk) begin
        prev_in <= in;
        if (in ^ prev_in)
        	anyedge <= in ^ prev_in;
        else
            anyedge <= 0;
    end
endmodule
