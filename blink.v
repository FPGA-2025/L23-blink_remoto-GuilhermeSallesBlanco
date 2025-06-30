module Blink #(
    parameter CLK_FREQ = 25_000_000 
) (
    input wire clk,
    input wire rst_n,
    output reg [7:0] leds
);

localparam ON_TIME = (CLK_FREQ * 3) / 4;   // 75% ON
localparam OFF_TIME = CLK_FREQ / 4;        // 25% OFF

reg [31:0] counter;
reg state; // 0: ON, 1: OFF

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        counter <= 32'b0;
        leds <= 8'b0;
        state <= 0;
    end else begin
        if(state == 0) begin 
            leds[0] <= 1'b1;
            leds[2] <= 1'b1;
            leds[4] <= 1'b1;
            leds[6] <= 1'b1;
            if(counter >= ON_TIME - 1) begin
                counter <= 32'b0;
                state <= 1;
            end else begin
                counter <= counter + 1;
            end
        end else begin 
            leds[0] <= 1'b0;
            leds[2] <= 1'b0;
            leds[4] <= 1'b0;
            leds[6] <= 1'b0;
            if(counter >= OFF_TIME - 1) begin
                counter <= 32'b0;
                state <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end
end

endmodule
