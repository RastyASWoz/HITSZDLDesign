`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/14 11:27:05
// Design Name: 
// Module Name: testbench
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


module testbench();

    reg rst;
    reg clk;
    reg button;
    reg [1:0] freq_set;
    reg dir_set;
    wire [7:0] led;
    
    flowing_water_lights t_bench(
        .clk(clk),
        .rst(rst),
        .button(button),
        .freq_set(freq_set),
        .dir_set(dir_set),
        .led(led)
        );
        
    always #5 clk = ~clk;
    
    initial begin
    
    clk=0;
    rst=0;
    button=0;
    freq_set=2'b00;
    dir_set=0;
    
    #10 rst = 1;
    #10 rst = 0;
    
    #10000000;
    
    #10 button = 1;
    #10 button = 0;
    
    #100000000;
    
    #10 button=1;
    #10 button=0;
    
    #10000000;
    
    #10 button=1;
    #10 button=0;
    
    #10 freq_set=2'b01;
    
    #1000000000;

    
    #10 dir_set=1;
    
    #100000000;

    
    #10 rst = 1;
    #10 rst =0;

    #10000000;

    
    #10 $finish;
    
    end

endmodule
