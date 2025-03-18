`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 22:33:14
// Design Name: 
// Module Name: base_conversion
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module base_conversion (
    input wire [7:0] binary,  
    output reg [7:0] octal_1, 
    output reg [7:0] octal_2, 
    output reg [7:0] octal_0,
    output reg [7:0] decimal_0, 
    output reg [7:0] decimal_1, 
    output reg [7:0] decimal_2,
    output reg [7:0] hex_0,    
    output reg [7:0] hex_1     
);

    always @(*) begin
        octal_2 = binary[7:6];   
        octal_1 = binary[5:3]; 
        octal_0 = binary[2:0];


        decimal_2 = binary / 100;  
        decimal_1 = (binary / 10) % 10; 
        decimal_0 = binary % 10; 

        hex_1 = binary[7:4];     
        hex_0 = binary[3:0];     
    end

endmodule


