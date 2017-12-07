`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/29 23:52:11
// Design Name: 
// Module Name: 8_ports_ctrl
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


module ports_ctrl(  output ena0,
                    output ena1,
                    output ena2,
                    output ena3,
                    output ena4,
                    output ena5,
                    output ena6,
                    output ena7,
                    input ctrl_out
    );
    assign ctrl_out = ena0;
    assign ctrl_out = ena1;
    assign ctrl_out = ena2;
    assign ctrl_out = ena3;
    assign ctrl_out = ena4;
    assign ctrl_out = ena5;
    assign ctrl_out = ena6;
    assign ctrl_out = ena7;
    
endmodule
