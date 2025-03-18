`timescale 1ns / 1ps


// slow_clk_gen.v
`timescale 1ns/1ps

module slow_clk_gen (
    input  wire clk,        
    input  wire reset,      
    output reg  slow_clk    
);

    
    localparam DIVIDER = 500_000;

    reg [18:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter   <= 19'd0;
            slow_clk  <= 1'b0;
        end else begin
            if (counter < (DIVIDER - 1)) begin
                counter <= counter + 1'b1;
            end else begin
                counter  <= 19'd0;
                slow_clk <= ~slow_clk; 
            end
        end
    end

endmodule

