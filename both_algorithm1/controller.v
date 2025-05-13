`timescale 1ns/1ns
module controller #(parameter n = 16,w=4) (
    q0, q1,eqz, lda, clra, shfta, ldq, clrq, shftq, 
ldm, clrf, addsub, dec, ldc, clk,start,done
);
input q0, q1,eqz,clk,start;
output reg lda, clra, shfta, ldq, clrq, shftq, ldm, clrf, addsub, dec, ldc,done;


parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101, s6 = 3'b110;
reg [2:0] state; 
/*
always @(posedge clk) begin
case (state)
s0: if (start) state <= s1;
s1: state <= s2;
s2: if ({q0, q1} == 2'b01) state <= s3;
else if ({q0, q1} == 2'b10) state <= s4;
else state <= s5;
s3: state <= s5;
s4: state <= s5;
s5: if (({q0, q1} == 2'b01) && !eqz) state <= s3;
else if (({q0, q1} == 2'b10) && !eqz) state <= s4;
else if (eqz) state <= s6;
s6: state <= s6;
default: state <= s0;
endcase
end
*/
always @(posedge clk) begin
case (state)
s0: if (start) begin  state <= s1; end
s1: begin state <= s2; end
s2: #5 begin
if ({q0, q1} == 2'b01)  state <= s3;
else if ({q0, q1} == 2'b10)  state <= s4;
else state <= s5;
end
s3: begin  state <= s5; end
s4: begin state <= s5; end
s5: #5 begin
if (({q0, q1} == 2'b01) &&!eqz)  state <= s3;
else if (({q0, q1} == 2'b10)&&!eqz)  state <= s4;
else if (eqz)  state <= s6;
end
s6: begin #5 state <= s6; end
default: begin #5 state <= s0; end
endcase
end

always @(state) begin
case (state)
s0: begin clra = 0; lda = 0; shfta = 0; clrq = 0; ldq = 0; shftq = 0; ldm = 0; clrf = 0; done = 0; end
s1: begin clra = 1; clrf = 1; ldc = 1; ldm = 1; end
s2: begin clra = 0; clrf = 1; ldc = 0; ldm = 0; ldq= 1; end
s3: begin lda = 1; addsub = 1; shfta = 0; shftq= 0; dec = 0; end
s4: begin lda = 1; addsub = 0; shfta = 0; shftq= 0; dec = 0; end
s5: begin shfta = 1; shftq= 1; lda = 0; ldq = 0; dec= 1;clrf=0; end
s6: begin done = 1; shfta=0;shftq=0;end
default: begin clra = 0; shfta = 0; ldq = 0; shftq= 0; end
endcase


end


endmodule
