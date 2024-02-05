`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:41 01/28/2024 
// Design Name: 
// Module Name:    freqDivider1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module freqDivider1(clk_in,clk_out);
input clk_in;
output clk_out;
reg clk_out;
reg [25:0] counter = 0;

	always @(posedge clk_in)begin
		if(counter == 10000 - 1)
			begin 
				counter <= 0;
				clk_out <= ~clk_out;
			end
		else
			begin
				counter <= counter + 1;
			end
	end

endmodule
