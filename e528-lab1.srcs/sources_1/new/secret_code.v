`timescale 1ns / 1ps
`include "event_det.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2024 01:09:57 PM
// Design Name: 
// Module Name: counter_fsm
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


module secret_code(
    input up_in,
    input down_in,
    input left_in,
    input right_in,
    input rst,
    input clk,
    output [6:0] ssd,
    output [2:0] SSG_EN  //disable three of four
    );

    localparam [3:0] WAIT_1 = 4'd0;
    localparam [3:0] WAIT_2 = 4'd1;
    localparam [3:0] WAIT_3 = 4'd2;
    localparam [3:0] WAIT_4 = 4'd3;
    localparam [3:0] E1 = 4'd4;
    localparam [3:0] E2 = 4'd5;
    localparam [3:0] E3 = 4'd6;
    localparam [3:0] SUCCESS = 4'd7;
    localparam [3:0] FAIL = 4'd8;
    
    localparam [6:0] NINE = 7'b0010000;
    localparam [6:0] E_VAL = 7'b0000110;
    localparam [6:0] OFF = 7'b1111111;
    
    wire multi_inputs, up, down, left, right, counter, active;
    reg [3:0] state;
    
    event_det up_det(clk, up_in, up);
    event_det down_det(clk, down_in, down);
    event_det left_det(clk, left_in, left);
    event_det right_det(clk, right_in, right);
    
    assign multi_inputs = (up + down + left + right) > 1;
    assign active = up | down | left | right;
    assign ssd = (state == SUCCESS) ? NINE : ((state == FAIL) ? E_VAL : OFF);
    assign SSG_EN = 3'b111;

    always @(posedge clk) begin
        if (multi_inputs) state <= FAIL;
        else if (rst) state <= WAIT_1;
        else if (active) begin
            case (state)
                WAIT_1: state <= up ? WAIT_2 : E1;
                WAIT_2: state <= left ? WAIT_3 : E2;
                WAIT_3: state <= left ? WAIT_4 : E3;
                WAIT_4: state <= right ? SUCCESS : FAIL;
                E1: state <= E2;
                E2: state <= E3;
                E3: state <= FAIL;
                default: state <= state;
            endcase
        end
    end  
endmodule
