module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    reg [1:0] state = 0;
    reg [2:0] bits = 0;
    reg [1:0] shift_counter = 0;
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            bits <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
        	case(state)
                0: begin
                    bits <= {bits[1:0], data};
                    if (bits == 3'b110 && data) begin
                        shift_ena <= 1;
                        state <= 1;
                    end
                end
                1: begin
                    shift_counter <= shift_counter + 1;
                    if (shift_counter == 3) begin
                        shift_ena <= 0;
                        counting <= 1;
                        state <= 2;
                    end
                end
                2: begin
                    if (done_counting) begin
                        counting <= 0;
                        done <= 1;
                        state <= 3;
                    end
                end
                3: begin
                    if (ack) begin
                        bits <= 0;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 0;
                    end
                end
        	endcase
        end
    end
endmodule
