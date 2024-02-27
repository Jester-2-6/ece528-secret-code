`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2024 01:09:57 PM
// Design Name: 
// Module Name: event_det
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


module event_det(
    input clk,
    input btn,
    output ev_out
    );
    reg prev_state, cur_state = 1'b0;
    
    always @(posedge clk) begin
        prev_state = cur_state;
        cur_state = btn;
    end
    
    assign ev_out = ~prev_state & cur_state;
    
endmodule
