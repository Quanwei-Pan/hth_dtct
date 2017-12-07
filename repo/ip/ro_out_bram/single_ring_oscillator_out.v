`timescale 1ns / 1ps

module ro_out_bram( input wire clk,
                                   input wire enable,
                                   input wire [31:0] ro_count_in,
                                   output reg [12:0] addr,
                                   output wire clkout,
                                   output wire [31:0]  ro_out,
                                   output wire we,
                                   output reg led
    );
     wire time_down_wire;
     reg [3:0] counter;
     reg ro_rst;
     
     parameter T10S = 4'd10;
     
     assign clkout = clk;
     assign we =  1'b1;
     
     initial begin
        addr <= 13'b0;
        ro_rst <= 1'b0;
     end
     
     timer_1s  timer(
                  .clk(clk),
                  .rst_n(1'b0),
                  .time_down(time_down_wire)
              );
              
    ring_oscillator ro( 
                        .enable(1'b1),
                        .rst_n(ro_rst),
                        .ro_fre(ro_out)
                        );
                        
     always @(posedge clk) begin
          if(counter == T10S)begin
            counter <= 4'b0;
            addr <= addr + 13'b100;
            ro_rst <= 1'b1; 
          end 
          else if (time_down_wire == 1'b1) begin
            counter <= counter + 1'b1;
            ro_rst <= 1'b0;
          end
          else begin
             counter <= counter;
             ro_rst <= 1'b0;
          end
     end
     
    always@(posedge clk) begin
        if(enable == 1'b1)
            led <= 1'b1;
        else
            led <= 1'b0;
    end
     
endmodule

module timer_1s(    input clk,
                    input rst_n,
                    output reg time_down
    );
        parameter T1S = 27'd124_999_999;
        parameter HALFT1S = 26'd62_499_999;
        parameter T1MS = 17'd124_999;
        parameter T100NS = 14'd12_499; 
        reg [26:0] counter;
        
        initial begin
        time_down <= 1'b0;
        counter <= 27'b0;
        end
        
        always @(posedge clk or negedge rst_n) begin
        if(counter == T100NS) begin
              time_down <= time_down + 1'b1;
              counter <= 27'd0;
              end
        else if(rst_n)begin
              time_down <= 1'b0;
              counter <= 27'd0;
        end
        else
            counter <= counter + 1'b1;
        end
        
 endmodule
 
 module ring_oscillator(
         input wire enable, 
         input wire rst_n,
         output reg[31:0] ro_fre
         );
		 
         wire out;
         (*ALLOW_COMBINATORIAL_LOOPS="TRUE", DONT_TOUCH="TRUE"*) wire[6:0] ro_line;
		 
         LUT2 #(.INIT(4'b0111)) inv1(.O(ro_line[1]),.I0(ro_line[0]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) inv2(.O(ro_line[2]),.I0(ro_line[1]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) inv3(.O(ro_line[3]),.I0(ro_line[2]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) inv4(.O(ro_line[4]),.I0(ro_line[3]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) inv5(.O(ro_line[5]),.I0(ro_line[4]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) inv6(.O(ro_line[6]),.I0(ro_line[5]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) ctl(.O(ro_line[0]),.I0(enable),.I1(ro_line[6])); 
		 
         assign out = ro_line[6];
         always @(posedge out or negedge rst_n) begin
            if(rst_n) begin
            ro_fre <= 32'h0000_0000;
                end
            else 
            ro_fre <= ro_fre + 1'b1;
         end
		 
 endmodule