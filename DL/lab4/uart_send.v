`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/29 14:16:48
// Design Name: 
// Module Name: uart_send
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


module uart_send(
    input        clk,        
    input        rst,        
    input        valid,       // indicates data is valid （logic high (1)）, last one clock
    input [7:0]  data,        // data to send
    output reg   dout         // connect to usb_uart tx pin
);

localparam IDLE  = 2'b00;   // 空闲态，发送高电平
localparam START = 2'b01;   // 起始态，发送起始位
localparam DATA  = 2'b10;   // 数据态，将8位数据位发送出去
localparam STOP  = 2'b11;   // 停止态，发送停止位

reg [1:0] current_stage;
reg [2:0] data_stage;
reg [1:0] next_stage;
reg [7:0] data_reg;
reg active;
reg frame_end;

freq_set u_freq_set#(
    .FREQ(32'd10416) // 9600 baud rate
)
(
    .clk(clk),
    .rst(rst),
    .valid(valid),
    .outer(frame_end)
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_stage <= IDLE;
        data_stage <= 0;
        dout <= 1;
        active <= 0;
    end else begin
        current_stage <= next_stage;
    end
end
always @(*) begin
    case (current_stage)
        IDLE: begin
            if (valid) begin
                next_stage = START;
                data_reg = data;
                active = 1;
            end else begin
                next_stage = IDLE;
            end
        end 
        START: begin
            if(frame_end) begin
                next_stage = DATA;
            end 
        end
        DATA: begin
            if(frame_end) begin
                if(data_stage < 8) begin
                    next_stage = DATA;
                end else begin
                    next_stage = STOP;
                end
            end
        end
        STOP: begin
            if(frame_end) begin
                next_stage = IDLE;
                active = 0;
                data_stage = 0;
            end
        end
        default: next_stage = IDLE;
    endcase
end
always @(posedge clk or posedge rst) begin
    case (current_stage)
        IDLE: begin
            dout <= 1;
        end
        START: begin
            dout <= 0;
        end
        DATA: begin
            dout <= data_reg[data_stage];
            data_stage <= data_stage + 1;
        end
        STOP: begin
            dout <= 1;
        end
        default: dout <= 1;
    endcase
end

endmodule