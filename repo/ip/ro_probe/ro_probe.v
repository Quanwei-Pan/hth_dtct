`timescale 1ns / 1ps

module top(input wire enable, 
         output wire out
         );
        ro_probe inst_ro_probe(.enable(enable),.out(out));
endmodule

module ro_probe(
         input wire enable, 
         output wire out
         );
         (*ALLOW_COMBINATORIAL_LOOPS="TRUE", DONT_TOUCH="TRUE"*) wire[6:0] ro_line;
		 
         LUT2 #(.INIT(4'b0111)) inv1(.O(ro_line[1]),.I0(ro_line[0]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) inv2(.O(ro_line[2]),.I0(ro_line[1]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) inv3(.O(ro_line[3]),.I0(ro_line[2]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) inv4(.O(ro_line[4]),.I0(ro_line[3]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) inv5(.O(ro_line[5]),.I0(ro_line[4]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) inv6(.O(ro_line[6]),.I0(ro_line[5]),.I1(1'b1));
		 LUT2 #(.INIT(4'b0111)) ctrl(.O(ro_line[0]),.I0(enable),.I1(ro_line[6])); 
		 
         assign out = ro_line[6];
 endmodule