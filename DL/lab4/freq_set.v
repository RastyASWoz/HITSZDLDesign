`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/29 14:19:07
// Design Name: 
// Module Name: freq_set
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

module freq_set
#(parameter FREQ = 32'd10000)
(
    input wire clk,
    input wire rst,
    input wire valid,
    output reg outer
    );
    reg [31:0] counter;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
        end
        else begin
            if(valid) begin
                if(counter == FREQ) begin
                outer<=1;
                counter<=0;
                end
                else begin
                    outer <=0;
                    counter <= counter+1;
                end
            end
            
        end
    end
endmodule
