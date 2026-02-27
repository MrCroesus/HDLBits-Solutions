module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    assign ena[1] = (q[3:0] == 9);
    assign ena[2] = (ena[1] && q[7:4] == 9);
    assign ena[3] = (ena[2] && q[11:8] == 9);
    
    BCD_counter counter1(clk, reset, 1'b1, q[3:0]);
    BCD_counter counter2(clk, reset, ena[1], q[7:4]);
    BCD_counter counter3(clk, reset, ena[2], q[11:8]);
    BCD_counter counter4(clk, reset, ena[3], q[15:12]);
endmodule

module BCD_counter(
    input clk,
    input reset,
    input enable,
    output [3:0] counter
);
    always @(posedge clk) begin
        if (reset)
            counter <= 0;
        else if (enable)
            if (counter == 9)
                counter <= 0;
        	else
                counter <= counter + 1;
        else
            counter <= counter;
    end
endmodule