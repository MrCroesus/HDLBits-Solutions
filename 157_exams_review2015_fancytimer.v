module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    reg [1:0] state;
    reg [2:0] bits;
    reg [3:0] delay;
    reg [1:0] delay_counter;
    reg [13:0] counter;
    
    assign count = delay;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            bits <= 0;
            delay <= 0;
            delay_counter <= 0;
            counter <= 0;
            
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                0: begin
                    bits <= {bits[1:0], data};
                    if (bits == 3'b110 && data) begin
                        state <= 1;
                        delay_counter <= 0;
                    end
                end
                1: begin
                    delay <= {delay[2:0], data};
                    delay_counter <= delay_counter + 1;
                    if (delay_counter == 3) begin
                        counting <= 1;
                        state <= 2;
                        counter <= 0;
                    end
                end
                2: begin
                    if (delay == 0 && counter == 999) begin
                        counting <= 0;
                        done <= 1;
                        state <= 3;
                    end
                    else if (counter == 999) begin
                        delay <= delay - 1;
                        counter <= 0;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                3: begin
                    if (ack) begin
                        state <= 0;
                        bits <= 0;
                        delay <= 0;
                        delay_counter <= 0;
                        counter <= 0;

                        counting <= 0;
                        done <= 0;
                    end
                end
            endcase
        end
    end
endmodule
