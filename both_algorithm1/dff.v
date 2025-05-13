`timescale 1ns/1ns
module dff(q0,q1,clk,clrf);
input q0,clk,clrf;
output reg q1;
always @(posedge clk) begin
if (clrf) q1<=0;
else q1<=q0;
end
endmodule
