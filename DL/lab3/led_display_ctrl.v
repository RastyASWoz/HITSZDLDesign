`timescale 1ns/1ps

module led_dispaly_ctrl (
    input wire clk,
    input wire rst,
    input wire button,
    input wire rbegin,
    input wire [7:0] sw,
    output reg [7:0] led,
    output [7:0] led_num
    );

    reg [31:0] show_counter;
    reg [3:0] show_num [7:0];
    reg [3:0] outnum;

    
    wire [3:0] one_num;
    
    reg [7:0] counter_20;
    wire rbegin_edge;
    reg[31:0] counter_20_count;
    reg running;
    reg rbegin_sync_0,rbegin_sync_1,rbegin_sync_2;

    reg [7:0] button_count;
    wire button_edge;


    assign one_num = sw[7] + sw[6] + sw[5] + sw[4] + sw[3] + sw[2] + sw[1] + sw[0];
    
    always @(*) begin
        show_num[7] = 4'b0001;
        show_num[6] = 4'b1000;
        
        show_num[5] = one_num/10;
        show_num[4] = one_num%10;
        show_num[3] = button_count/16;
        show_num[2] = button_count%16;
        show_num[1] = counter_20/10;
        show_num[0] = counter_20%10;
    end
    


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            led <= 8'b11111110;
            show_counter <= 0;
        end else begin
            if (show_counter==100000) begin
                show_counter <= 0;
                led <= {led[6:0], led[7]};
            end else begin
                show_counter <= show_counter + 1;
            end
        end
    end

    always @(*) begin
        case (led)
            8'b11111110: outnum = show_num[0];
            8'b11111101: outnum = show_num[1];
            8'b11111011: outnum = show_num[2];
            8'b11110111: outnum = show_num[3];
            8'b11101111: outnum = show_num[4];
            8'b11011111: outnum = show_num[5];
            8'b10111111: outnum = show_num[6];
            8'b01111111: outnum = show_num[7];
            default: outnum = 8'b11111110;
        endcase
    end

    num_to_led num_to_led_inst (
        .num(outnum),
        .led_num(led_num)
    );

    button_edge rbegin_edge_inst (
        .clk(clk),
        .rst(rst),
        .button(rbegin),
        .button_edge(rbegin_edge)
    );

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            counter_20 <= 0;
            counter_20_count <= 0;
            
            running <= 0;
        end
        else begin
            if(rbegin_edge) begin
                running <= 1;
                counter_20 <=0;
            end
            
            if(running) begin
                counter_20_count <= counter_20_count + 1;
                if(counter_20_count == 10000000) begin
                    counter_20 <= counter_20 + 1;
                    counter_20_count <= 0;
                end
                if(counter_20 == 20) begin
                    
                    running <= 0;
                end
            end
        end
    end
    
    button_edge button_edge_inst (
        .clk(clk),
        .rst(rst),
        .button(button),
        .button_edge(button_edge)
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            button_count <= 0;
        end
        else begin
            if(button_edge) begin
                button_count <= button_count + 1;
            end
        end
    end

endmodule