`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/11 20:45:23
// Design Name: 
// Module Name: reg8file
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


module reg8file(
    input clk,                
    input clr,                
    input en,                 
    input [2:0] wsel,   
    input [2:0] rsel,    
    input [7:0] d,   
    output reg [7:0] q 
);

    reg [7:0] regfile [7:0];


    always @(*) begin
        q = regfile[rsel];
    end


    always @(posedge clk or posedge clr) begin
        if (clr) begin
            regfile[0] <= 8'b0;
            regfile[1] <= 8'b0;
            regfile[2] <= 8'b0;
            regfile[3] <= 8'b0;
            regfile[4] <= 8'b0;
            regfile[5] <= 8'b0;
            regfile[6] <= 8'b0;
            regfile[7] <= 8'b0;
        end else if (en) begin
            regfile[wsel] <= d;
        end
    end

    

endmodule

