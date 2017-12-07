`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  none
// Engineer: ss.pan
// 
// Create Date: 2017/11/29 21:32:11
// Design Name: ro_counter.v
// Module Name: ro_counter
// Project Name: 
// Target Devices: zynq-7010
// Tool Versions: 
// Description: ro_in, ro frequency wire; clk, system clock; rst_n, reset pin; 
// clk_count, clk counter output reg; done, signal for one time running.
// 
// Dependencies: none
//  
// Revision: v0.01
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ro_counter( input ro_in,
                   input clk,
                   input rst_n,
                   output reg [31:0] clk_count,
                   output reg done
    );
    
    reg [23:0] ro_count;
    reg en;
 
    always@(posedge ro_in or negedge rst_n) begin
        if(!rst_n) begin
			ro_count <= 0;
            en <= 1'b1;
        end else if(ro_count >= 17'd76141) begin
            ro_count <= 0;
            en <= 0;
        end else begin
            ro_count <= ro_count + 1'b1;
        end
    end
     
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin 
            clk_count <= 0;
            done <= 0;
        end else  if(clk_count == 32'hffff_ffff) begin
            clk_count <= 0;
        end else if(en) begin
            clk_count <= clk_count + 1;
            done <= 1;
        end else 
            done <= 0;
    end
endmodule
