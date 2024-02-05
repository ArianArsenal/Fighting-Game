`timescale 1ps/1ps
//changing 3 bit to 6 bit

module gameLogic(
	playerLED1,
	playerLED2,
	player1,
	player2,
	clock,
	reset,
	player1_position,
	player2_position,
	player1_health, 
	player2_health,
	winner1,
	winner2
);


output reg[2:0] playerLED1; //Player 1 (samte chap) 2 1 0 == _ _ _
output reg[0:2] playerLED2; // Player 2 (samte rast) 0 1 2 == _ _ _


//3 bit 
//input[2:0] player1; //action
//input[2:0] player2; //action


//6 bit
input[5:0] player1;	//action
input[5:0] player2; //action






input clock;
input reset;
output reg[2:0] player1_position; //position starts from 0
output reg[2:0] player2_position;  //position starts from 5
output reg[1:0] player1_health, player2_health; //health starts from 3

output reg winner1;//winner 1
output reg winner2; //winner 2 

//current state of players and their last actions
reg [5:0] current_player1 , current_player2;
reg[5:0] last_player1, last_player2;

///@encoding for the 3bit inputs for each player
//3 bit
//parameter Wait = 3'b000 , Punch = 3'b001 , Kick = 3'b010 , Move_Left = 3'b011 , Move_Right = 3'b100 , Jump = 3'b101;

//6 bit 
parameter Wait =6'b100000 , Move_Left = 6'b010000 , Move_Right = 6'b001000 , Jump = 6'b000100 , Punch = 6'b000010 , Kick = 6'b000001;



initial begin
    /*
    *   Position (array)
    *   0 1 2 | 3 4 5
    *   
    *   Health = 3
    *
    */

    player1_position= 0; 
    player2_position = 5;

    player1_health = 3;
    player2_health = 3;

    //initial state 
    current_player1 = Wait;
    current_player2 = Wait;

    //initial last state
    last_player1 = Wait;
    last_player2 = Wait;

    //initial winner state 
    winner1 = 0;
    winner2 = 0;

end

always @(posedge clock) begin

    //revert back to the first state of game
    if (reset) begin

        player1_health = 3;
        player2_health = 3;

        player1_position = 0;
        player2_position = 5;

        current_player1 = Wait;
        current_player2 = Wait;

        last_player1 = Wait;
        last_player2 = Wait;
    end
    else begin
        //if not reset , apply the actions
        current_player1 = player1;
        current_player2 = player2; 
    end 
	 
	 
	 
    //player 1 movement
    if (current_player1 == Move_Left && player1_position > 0) 
        player1_position = player1_position - 1; //He can move to the left
    else if (current_player1 == Move_Right && player1_position < 2 ) 
        player1_position = player1_position + 1;

    //player 2 movement
    if(current_player2 == Move_Left && player2_position > 3)
        player2_position = player2_position - 1;//He can move to the left
    else if(current_player2 == Move_Right && player2_position < 5)
        player2_position = player2_position + 1;



    //attacks in 1 range  _ _ *|* _ _
    if (player2_position - player1_position == 1 && current_player1 != Move_Left && current_player2 != Move_Right) begin

        //Punch (olaviat)
        if(current_player1 == Punch && current_player2 != Jump && current_player2 != Punch) player2_health = player2_health - 2;
        else if(current_player2 == Punch && current_player1 != Jump && current_player1 != Punch) player1_health = player1_health - 2;

        //Kick
        else if(current_player1 == Kick && current_player2 != Jump && current_player2 != Kick && current_player2 != Punch) player2_health = player2_health -1;
        else if(current_player2 == Kick && current_player1 != Jump && current_player1 != Kick && current_player1 != Punch) player1_health = player1_health -1;

        //if both Punch ==> knockback
        else if(current_player1 == Punch && current_player2 == Punch)begin
            player1_position = player1_position - 1 ;
            player2_position = player2_position + 1;
        end

        //if both Kick ==> Knockback
        else if(current_player1 == Kick && current_player2 == Kick)begin
            player1_position = player1_position - 1 ;
            player2_position = player2_position + 1;
        end
    end

    //attacks in 2 range _ * _|* _ _
    if (player2_position - player1_position == 2 && current_player1 != Move_Left && current_player2 != Move_Right) begin
        
        if (current_player1 == Kick && current_player2 != Kick && current_player2 != Jump) player2_health = player2_health - 1;
        else if(current_player2 == Kick && current_player1 != Kick && current_player1 != Jump) player1_health = player1_health - 1;

        //if both Kick ==> Knockback

	         else if(current_player1 == Kick && current_player2 == Kick) begin
            player1_position = player1_position - 1;
            player2_position = player2_position + 1;
        end
    end

    

    //Wait 1
    if(current_player1 == Wait && last_player1 == Wait)begin
        if(player1_health < 3) player1_health = player1_health + 1;
    end
    last_player1 = current_player1;

    //Wait 2
    if(current_player2 == Wait && last_player2 == Wait)begin
        if(player2_health < 3)player2_health = player2_health + 1;
    end
    last_player2 = current_player2;

	 

end

	//Checking Winner
	always @(posedge clock) begin
		 //if player 1 dies , player 2 wins
		 if(player1_health == 0 && player2_health != 0) winner2 = winner2 + 1;
		 //if player 2 dies , player 1 wins
		 else if(player2_health == 0 && player1_health != 0) winner1 = winner1 + 1;
	end


	always@(player1_position) begin
		if(player1_position == 0)playerLED1 = 3'b100;
		else if(player1_position == 1)playerLED1 = 3'b010;
		else if(player1_position == 2)playerLED1 = 3'b001;
	end

	always@(player2_position) begin
		if(player2_position == 5)playerLED2 = 3'b001;
		else if(player2_position == 4)playerLED2 = 3'b010;
		else if(player2_position == 3)playerLED2 = 3'b100;
	end




endmodule