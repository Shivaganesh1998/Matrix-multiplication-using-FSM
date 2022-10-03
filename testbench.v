`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2022 11:16:52
// Design Name: 
// Module Name: testbench
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


module testbench();

reg [255:0] a;
reg [255:0] b;
reg clk,reset;
// Outputs
wire [511:0] result;


// Instantiate the Unit Under Test (UUT)
matrix_mul uut (
.a(a),
.b(b),
.reset(reset),
.clk(clk),
.result(result)
);

initial
clk=0;
always
#1 clk=~clk;


initial begin
// Apply Inputs

reset=1;
#15 reset=0;

// A = 0; B = 0; #10;
b = {32'd1,32'd2,32'd3,32'd2,32'd3,32'd1,32'd3,32'd2};
a= {32'd2,32'd3,32'd4,32'd2,32'd4,32'd2,32'd3,32'd2};
#500
reset=1;
#20 reset=0;

b = {32'd0,32'd2,32'd3,32'd4,32'd3,32'd5,32'd3,32'd2};
a= {32'd2,32'd2,32'd4,32'd0,32'd4,32'd2,32'd5,32'd4};
#500 $finish;
end


endmodule
