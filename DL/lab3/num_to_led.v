`timescale 1ns / 1ps
module num_to_led (
    input [3:0] num,
    output reg [7:0] led_num
    );
    always @(*) begin
        case (num)
            4'h0: led_num = 8'b00000011;
            4'h1: led_num = 8'b10011111;
            4'h2: led_num = 8'b00100101;
            4'h3: led_num = 8'b00001101;
            4'h4: led_num = 8'b10011001;
            4'h5: led_num = 8'b01001001;
            4'h6: led_num = 8'b01000001;
            4'h7: led_num = 8'b00011111;
            4'h8: led_num = 8'b00000001;
            4'h9: led_num = 8'b00001001;
            4'ha: led_num = 8'b00010001;
            4'hb: led_num = 8'b11000001;
            4'hc: led_num = 8'b01100011;
            4'hd: led_num = 8'b10000101;
            4'he: led_num = 8'b01100001;
            4'hf: led_num = 8'b01110001;
            default: led_num = 8'b00000011;
        endcase
    end
endmodule