`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/30 00:03:28
// Design Name: 
// Module Name: ports_ro_out
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


module ports_ro_out(  input ro_in0,
                    input ro_in1,
                    input ro_in2,
                    input ro_in3,
                    input ro_in4,
                    input ro_in5,
                    input ro_in6,
                    input ro_in7,
                    output ro_out
    );
    assign ro_out = ro_in0;
    assign ro_out = ro_in1;
    assign ro_out = ro_in2;
    assign ro_out = ro_in3;
    assign ro_out = ro_in4;
    assign ro_out = ro_in5;
    assign ro_out = ro_in6;
    assign ro_out = ro_in7;
    
endmodule
