`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/14 10:32:17
// Design Name: 
// Module Name: flowing_water_lights
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


module flowing_water_lights (
    input wire clk,          
    input wire rst,         
    input wire button,      
    input wire [1:0] freq_set, 
    input wire dir_set,      
    output reg [7:0] led     
);

    
    reg [31:0] counter;
    reg [31:0] max_count;
    reg running;
    reg button_sync_0, button_sync_1, button_sync_2;
    reg button_edge;

    
    always @(*) begin
        case (freq_set)
            2'b00: max_count = 1000000;  // 100Hz
            2'b01: max_count = 10000000; // 10Hz
            2'b10: max_count = 25000000; // 4Hz
            2'b11: max_count = 50000000; // 2Hz
            default: max_count = 1000000;
        endcase
    end

    assign counte_end = running & (counter == max_count);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            led <= 8'b00000001;
            counter <= 0;
            running <= 0;
            button_sync_0 <= 0;
            button_sync_1 <= 0;
            button_sync_2 <= 0;
            button_edge <= 0;
        end else begin
            
            button_sync_0 <= button;
            button_sync_1 <= button_sync_0;
            button_sync_2 <= button_sync_1;
            button_edge <= button_sync_1 & ~button_sync_2;

            if (button_edge) begin
                running <= ~running;
            end

            if (running) begin
                if (counte_end) begin
                    counter <= 0;
                    if (dir_set) begin
                        led <= {led[6:0], led[7]}; 
                    end else begin
                        led <= {led[0], led[7:1]}; 
                    end
                end else begin
                    counter <= counter + 1;
                end
            end
        end
    end
endmodule