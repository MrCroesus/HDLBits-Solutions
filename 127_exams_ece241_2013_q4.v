module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [1:0] prev_state, state, next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state = 0;
        end else begin
            case (s)
                3'b000: begin
                    next_state = 0;
                end
                3'b001: begin
                    next_state = 1;
                end
                3'b011: begin
                    next_state = 2;
                end
                3'b111: begin
                    next_state = 3;
                end
            endcase
            if (state != next_state) begin
                state <= next_state;
            	prev_state <= state;
            end
        end
    end
    
    assign fr1 = (state == 0 || state == 1 || state == 2);
    assign fr2 = (state == 0 || state == 1);
    assign fr3 = (state == 0);
    assign dfr = (state < prev_state || state == 0);

endmodule
