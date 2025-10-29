`timescale 1ns/1ps

module reg8file_tb;  

    reg clk;          
    reg clr;          
    reg en;           
    reg [2:0] wsel;   
    reg [2:0] rsel;   
    reg [7:0] d;      
    wire [7:0] q;     

    reg8file u_reg8file (
        .clk(clk),
        .clr(clr),
        .en(en),
        .wsel(wsel),
        .rsel(rsel),
        .d(d),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        clr = 0;
        en = 0;
        wsel = 3'b000;
        rsel = 3'b000;
        d = 8'b00000000;

        #10 clr = 1;  
        #10 clr = 0;  

        #10 en = 1; wsel = 3'b000; d = 8'hAA;
        #10 en = 0; 

        #10 rsel = 3'b000;
        #10;

        #10 en = 1; wsel = 3'b001; d = 8'hBB;
        #10 en = 0;

        #10 rsel = 3'b001;
        #10;

        #10 en = 1; wsel = 3'b010; d = 8'hCC;
        #10 en = 0;

        #10 rsel = 3'b010;
        #10;

        #10 clr = 1;  
        #10 clr = 0;

        #10 rsel = 3'b000;
        #10;

        #10 rsel = 3'b001;
        #10;

        #10 rsel = 3'b010;
        #10;

        #10 $finish;
    end

endmodule

