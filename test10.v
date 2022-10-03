`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2022 22:40:46
// Design Name: 
// Module Name: test10
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



module matrix_mul(a,b,clk,reset,result);

parameter n=4,m=2;
input [n*m*32-1:0] a;
input [m*n*32-1:0] b;
reg [31:0]arr1[n-1:0][m-1:0];
reg [31:0]arr2[m-1:0][n-1:0];
reg [31:0]mul[n-1:0][n-1:0];
output reg [n*n*32-1:0] result;
reg [n*n*32-1:0] result1;
input clk,reset;
parameter s0=4'b0000,s1=4'b0001,s2=4'b0010,s3=4'b0011,s4=4'b0100,s5=4'b0101,s6=4'b0110,s7=4'b0111,s8=4'b1000,s9=4'b1001,s10=4'b1010;
reg [3:0] ps,ns;
integer i,j,count,e,f;
integer p,q,r;

 

always@(posedge clk)
begin

if(reset==1)
begin
ps<=s7;
end

else ps<=ns;

end


always@(ps)
begin


case(ps)
s7:begin
result1=0;
result=0;
i=0;
count=0;
e=0;
f=0;
j=0;
p=0;
q=0;
r=0;
ns=s0;
end

s5: ns=s1;

s6: ns=s4;
s10:ns=s9;

s0:begin
if(i<n)begin
ns=s1;
end

else begin
count=0;
ns=s8;
end
end

s1:begin

if(j<m)begin
arr1[i][j]=a>>(count*32);
count=count+1;
j=j+1;
ns=s5;
end

else begin
j=0;
i=i+1;
ns=s0;
end

end


s2:begin
q=0;
if(p<n) ns=s3;
else 
result=result1;
end

s3:begin
if(q<n) begin
mul[p][q]=0;
ns=s4;
end
else begin
p=p+1;
ns=s2;
end
end

s4:begin
if(r<m)begin
mul[p][q]=mul[p][q]+(arr1[p][r]*arr2[r][q]);
r=r+1;
ns=s6;
end
else begin
result1=result1>>32;
result1[((32*n*n)-1):((32*n*n)-32)]=mul[p][q];
r=0;
q=q+1;

ns=s3;
end
end
s8:begin
if(e<m)begin
ns=s9;
end

else begin
ns=s2;
end
end

s9:begin

if(f<n)begin

arr2[e][f]=b>>(count*32);
count=count+1;
/*if(e<n&&f<n)
begin
mul[e][f]=0;
mul[f][e]=0;
end*/
f=f+1;
//mul[n-1][n-1]=0;
ns=s10;
end

else begin
f=0;
e=e+1;
ns=s8;
end

end

endcase
end
endmodule

