module Blink #(
    parameter CLK_FREQ = 25_000_000 
) (
    input wire clk,
    input wire rst_n,
    output reg [7:0] leds
);

localparam ONE_SECOND = CLK_FREQ;
localparam HALF_SECOND = CLK_FREQ / 2;
localparam QUARTER_SECOND = CLK_FREQ / 4;

reg [31:0] counter;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        counter <= 32'b0;
        leds <= 8'b0;
    end else begin
        if(counter >= QUARTER_SECOND - 1) begin
            counter <= 32'b0;
            leds [0] <= ~leds[0];
            leds [2] <= ~leds[2];
            leds [4] <= ~leds[4];
            leds [6] <= ~leds[6];
        end else begin
            counter <= counter + 1;
        end
    end
end
    
endmodule
