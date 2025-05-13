`timescale 1ns/1ns
module pipo #(parameter n)(bus,m,clk,ldm);
input [n-1:0] bus;
input clk,ldm;
output reg [n-1:0] m;
always @(posedge clk) begin 
if (ldm) m<=bus;
end
endmodule