
`timescale 1ns/1ps


module gameLogic_tb;

    reg[2:0] player1; //action
    reg[2:0] player2; //action
    reg clock,reset;
    wire [2:0] player1_position;  //position starts from 0
    wire[2:0] player2_position;  //position starts from 5
    wire[1:0] player1_health, player2_health; //health starts from 3
    wire winner1;
    wire winner2;
	 
	 wire playerLED1;
	 wire playerLED2;

    gameLogic uut(playerLED1,playerLED2,player1,player2,clock,reset,player1_position,player2_position,player1_health,player2_health,winner1,winner2);


    initial begin
        clock = 0;
        repeat(50)
            #50 clock = ~ clock;
    end  

    initial begin

        //$dumpfile("gameLogic_tb.vcd");
        //$dumpvars(0,uut);

        /*
        * Wait = 3'b000 
        *
        * Punch = 3'b001 
        * Kick = 3'b010 
        *
        * Move_Left = 3'b011
        * Move_Right = 3'b100 
        * Jump = 3'b101
        *
        */

        // reset = 1;
        // #100
        // reset = 0;

        // #200;
		  reset = 1;
		  #10;
		  reset = 0;
		  #10;

        player1 = 3'b100;   //Move Right
        player2 = 3'b011;   //Move Left
        #200;

        //! TEST
        // player1 = 3'b000;
        // player2 = 3'b000;


        player1 = 3'b100;   //Move Right
        player2 = 3'b011;   //Move Left
        #200;

        player1 = 3'b001;   //Punch
        player2 = 3'b101;   //Jump
        #200;

        player1 = 3'b001; //Punch
        player2 = 3'b010; //Kick
        #200;

        player1 = 3'b001; //Punch
        player2 = 3'b001; //Punch
        #200;

        player1 = 3'b100; //Move Right
        player2 = 3'b000; //Wait
        #200;

        player1 = 3'b101; //Jump
        player2 = 3'b000; //Wait
        #200;

        player1 = 3'b001; //Punch
        player2 = 3'b010; //Kick
        #200;

        player1 = 3'b010;   //Kick
        player2 = 3'b101;   //Jump
        #200;

        player1 = 3'b011;   //Left
        player2 = 3'b010;   //Kick
        #200;

        player1 = 3'b010;   //Kick
        player2 = 3'b011;   //Left
        #200;

        player1 = 3'b010; //Kick
        player2 = 3'b000; //Left
        #200;

        //! a test case for when player 2 dies and 1 wins
        //! Clock 31
        // player1 = 3'b010;   //Kick
        // player2 = 3'b001;   //Punch
    end

endmodule
