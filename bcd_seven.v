`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:13 01/28/2024 
// Design Name: 
// Module Name:    bcd_seven 
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
module bcd_seven(input [1:0] health1,input[1:0]health2,output reg[4:0] SEG_SEL,output reg[7:0] SEG_DATA,input clk);

	reg present = 1'b0;

	always@(posedge clk)begin
		case(present)
			1'b0: begin
				case(health2)
					//change
					2'b00: SEG_DATA = 8'b00111111;
					2'b01: SEG_DATA = 8'b00000110;
					2'b10: SEG_DATA = 8'b01011011;
					2'b11: SEG_DATA = 8'b01001111;
				endcase
				SEG_SEL = 5'b00001;
			end
			1'b1: begin
				case(health1)
					2'b00: SEG_DATA = 8'b00111111;
					2'b01: SEG_DATA = 8'b00000110;
					2'b10: SEG_DATA = 8'b01011011;
					2'b11: SEG_DATA = 8'b01001111;
				endcase
				SEG_SEL = 5'b01000;
			end
		endcase
		present = ~present;
	end

endmodule
