module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    reg [6:0] global_history;
    reg [1:0] counter [0:127];
    wire actual;
    wire [1:0] counter_val;
    assign counter_val = counter[train_pc ^ train_history];
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            for (integer i = 0; i < 128; i += 1) begin
                counter[i] = 2'b01;
            end
            global_history <= 0;
        end else begin
            if (train_valid) begin
                if (counter_val == 2'b11 && train_taken) begin
                    counter[train_pc ^ train_history] <= 2'b11;
                end else if (counter_val == 2'b00 && ~train_taken) begin
                    counter[train_pc ^ train_history] <= 2'b00;
                end else begin
                    counter[train_pc ^ train_history] <= train_taken ? counter_val + 2'b01 : counter_val - 2'b01;
                end
            end
            
                    
            if (train_valid & train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end else begin
                global_history <= global_history;
            end
        end
    end
    
    assign predict_taken = counter[predict_pc ^ global_history][1];
    assign predict_history = global_history;
    
endmodule
