`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/29 14:27:26
// Design Name: 
// Module Name: main_ctrl
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


module main_ctrl(
    input wire clk,
    input wire rst,
    output wire dout 
    );
    

    
    uart_send u_uart_send(
        .clk(clk),
        .rst(rst),
        .valid(uart_edge),
        .data(outnum),
        .dout(dout)
    );

endmodule
