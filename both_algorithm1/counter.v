`timescale 1ns/1ns
module counter #(parameter w,n)(count,ldc,dec,clk);
input ldc,dec,clk;
output reg [w-1:0] count;
always @(posedge clk) begin 
if (ldc) count <= n-1;
else if (dec) count<=count-1;
end
endmodule

