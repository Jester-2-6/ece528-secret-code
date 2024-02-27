`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2024 10:45:03 PM
// Design Name: 
// Module Name: secret_code_tb
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


module secret_code_tb;
    reg up_in, down_in, left_in, right_in, reset, clk;

    wire [6:0] ssd;
    wire [2:0] SSG_EN; 

    secret_code secret_code_0(
        .up_in(up_in),
        .down_in(down_in),
        .left_in(left_in),
        .right_in(right_in),
        .rst(reset),
        .clk(clk),
        .ssd(ssd),
        .SSG_EN(SSG_EN)
    );

    always #10 clk = ~clk;

    initial begin
        up_in = 0;
        down_in = 0;
        left_in = 0;
        right_in = 0;
        reset = 1;
        clk = 0;
        #30 reset = 0;

        // correct code
        #30 up_in = 1;
        #30 up_in = 0;
        #30 left_in = 1;
        #30 left_in = 0;
        #30 left_in = 1;
        #30 left_in = 0;
        #30 right_in = 1;
        #30 right_in = 0;

        // wait to observe and reset
        #50 reset = 1;
        #30 reset = 0;

        // incorrect code from digit 1
        #30 down_in = 1;
        #30 down_in = 0;
        #30 left_in = 1;
        #30 left_in = 0;
        #30 left_in = 1;
        #30 left_in = 0;
        #30 right_in = 1;
        #30 right_in = 0;

        // wait to observe and reset
        #50 reset = 1;
        #30 reset = 0;

        // incorrect code from digit 2
        #30 up_in = 1;
        #30 up_in = 0;
        #30 down_in = 1;
        #30 down_in = 0;
        #30 left_in = 1;
        #30 left_in = 0;
        #30 right_in = 1;
        #30 right_in = 0;

        // wait to observe and reset
        #50 reset = 1;
        #30 reset = 0;

        // incorrect code from digit 3
        #30 up_in = 1;
        #30 up_in = 0;
        #30 left_in = 1;
        #30 left_in = 0;
        #30 down_in = 1;
        #30 down_in = 0;
        #30 right_in = 1;
        #30 right_in = 0;

        // wait to observe and reset
        #50 reset = 1;
        #30 reset = 0;

        // incorrect code from digit 4
        #30 up_in = 1;
        #30 up_in = 0;
        #30 left_in = 1;
        #30 left_in = 0;
        #30 left_in = 1;
        #30 left_in = 0;
        #30 down_in = 1;
        #30 down_in = 0;

        // wait to observe and reset
        #50 reset = 1;
        #30 reset = 0;

        // multiple presses at once
        #30 up_in = 1; left_in = 1;
        #30 up_in = 0; left_in = 0;
        #30 left_in = 1;
        #30 left_in = 0;
        #30 left_in = 1;
        #30 left_in = 0;
        #30 down_in = 1;
        #30 down_in = 0;

        #100 $finish;
    end
endmodule
