`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/26 15:49:50
// Design Name: 
// Module Name: button_edge
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


module button_edge (
    input clk,
    input rst,
    input button,
    output reg button_edge
    );
    reg [31:0] counter;
    reg [2:0] button_sync;
    reg button_pressing;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            counter <= 0;
            button_sync <= 0;
            button_edge <= 0;
            button_pressing <= 0;
        end
        else begin
            button_sync <= {button_sync[1:0], button};
            
            if(button_sync[2] & button_sync[1]) begin
                counter <= counter + 1;
            end
            else begin
                counter <= 0;
            end

            if(counter == 32'd1000000) begin
                button_pressing <= 1;
            end
            if(button_pressing & ~button_sync[2]) begin
                button_edge <= 1;
                button_pressing <= 0;
            end
            else begin
                button_edge <= 0;
            end
        end
    end
endmodule
