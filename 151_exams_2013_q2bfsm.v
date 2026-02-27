module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    reg [3:0] state;
    
    always @(posedge clk) begin
        if (~resetn) begin
            state <= 0;
            f <= 0;
            g <= 0;
        end else begin
            case (state)
                0: begin
                    state <= 1;
                    f <= 1;
                end
                1: begin
                    state <= 2;
                    f <= 0;
                end
                2: state <= x ? 3 : 2;
                3: state <= ~x ? 4 : 3;
                4: begin
                    state <= x ? 5 : 2;
                    g <= x;
                end
                5: state <= y ? 7 : 6;
                6: begin
                    state <= y ? 7 : 8;
                    g <= y;
                end
            endcase
        end
    end
endmodule
