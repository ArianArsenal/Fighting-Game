`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:16 01/28/2024 
// Design Name: 
// Module Name:    Top 
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
module Top(output[2:0] playerLED1,output[0:2]playerLED2,output[4:0]health_SEL,output[7:0]player_DATA,

//3 bit
//input[2:0] player1, //action
//input[2:0] player2, //action

//6 bit
input[5:0] player1,
input[5:0] player2,


input clock,
input reset
);

wire[1:0] player1_health;
wire[1:0] player2_health;

wire winner1;
wire winner2;
wire clkOUT;
wire clkBCD;

	
	


freqDivider2 fq2(clock,clkOUT);	//the one with high frequence
freqDivider1 fq1(clock,clkBCD); //the one with less frequence 

bcd_seven BCD7(player1_health,player2_health,health_SEL,player_DATA,clkBCD);

gameLogic game1(playerLED1,playerLED2,player1,player2,clkOUT,reset,player1_position,player2_position,player1_health, player2_health,winner1,winner2);




	 
endmodule
