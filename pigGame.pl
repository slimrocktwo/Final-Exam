#!/bin/perl

##Cis 140 Final Exam - Pigs Dice Game
##Created by Steve Langewicz II
#12-15-16

use 5.16.3;

my ($dieA, $dieB, $playerScore, $turnScore, $AIScore, $tempScore, $name, $endTurn, $stopGame, $playerAction);
use constant WIN => 100;

sub main {
        startGame();
        while ($stopGame != 1){
                playerGameplay();
                $endTurn = 0;
                if ($playerScore < WIN){
                        say "Computer's Turn";
                        AIGameplay();
                        $endTurn = 0;
                }
                if ($playerScore >= WIN){
                        say "You Win $name!";
                        sleep 5;
                        $stopGame == 1;
                }
                if ($AIScore >= WIN){
                        say "Computer Wins.";
                        sleep 5;
                        $stopGame == 1;
                }else{
                        say "\n$name: $playerScore - Computer: $AIScore";
                        sleep 2;
                }
        }
}

main();

sub startGame{
        $endTurn = 0;
        $stopGame = 0;
        system ("clear");
        print "Welcome to Pigs! Enter you name: ";
        chomp ($name = <STDIN>);
        say "First to 100 wins. Good Luck!";
        sleep 3;
}

sub playChoice{
        $tempScore = $playerScore + $turnScore;
        print "You rolled $turnScore. If you hold, your score will be $tempScore.\n Press 1 to Hold or 0 to Roll:";
        chomp ($playerAction = <STDIN>);
        $tempScore = 0;
        while ($playerAction > 1 || $playerAction < 0){
                say "You must choose 0 for roll or 1 for hold. Try Again.";
                sleep 2;
                system ("clear");
                print "Your score is $playerScore, Do you want to Hold or Roll? (1 for Hold, 0 for Roll): ";
                chomp ($playerAction = <STDIN>);
        }
        if ($playerAction == 1){
                $endTurn = 1;
                $playerScore = $playerScore + $turnScore;
                $turnScore = 0;
        }

}

sub AIChoice{
        $tempScore = $AIScore + $turnScore;
        $turnScore = 0;
        if ($tempScore >= 80){
                $endTurn = int rand 2;
        }
        if ($endTurn == 1){
                $AIScore = $AIScore + $tempScore;
                $tempScore = 0;
                say "Computer will hold. New score: $AIScore";
                sleep 3;
        }
}


sub rollDice{
        system ("clear");
        $dieA = int rand 6 + 1;
        while ($dieA == 0){
                $dieA = int rand 6 + 1;
        }
        $dieB = int rand 6 + 1;
        while ($dieB == 0){
                $dieB = int rand 6 + 1;
        }
        print "---  ---\n";
        say "|$dieA|  |$dieB|";
        say "---  ---\n\n";
}


sub playerGameplay{
        while ($endTurn != 1){
                rollDice();
                say "$name 's roll";
                if (!($dieA == 1) && !($dieB == 1)){
                        $turnScore = $turnScore + $dieA + $dieB;
                        playChoice();
                }
                if (($dieA == 1) && ($dieB == 1)){
                        say "\nSnake Eyes! End of turn and loose all points";
                        sleep 2;
                        $playerScore = 0;
                        $endTurn = 1;
                }
                if (($dieA == 1 || $dieB == 1) && !($dieA == 1 && $dieB == 1)){
                        say "\nNo score this roll, end of turn";
                        sleep 2;
                        $endTurn = 1;
                }
                if (($dieA == $dieB) && !($dieA == 1 && $dieB == 1)){
                        $turnScore = $turnScore + $dieA + $dieB;
                       $turnScore = $turnScore + $dieA + $dieB;
                        say "\nDoubles! Auto Roll!!";
                        sleep 2;
                }
        }
}

sub AIGameplay{
        while ($endTurn != 1){
                rollDice();
                say "Computer's Roll";
                if (!($dieA == 1) && !($dieB == 1)){
                        $turnScore = $turnScore + $dieA + $dieB;
                        AIChoice();
                }
                if (($dieA == 1 && $dieB == 1)){
                        say "Snake Eyes! End of turn and loose all points";
                        sleep 1;
                        $playerScore = 0;
                        $endTurn = 1;
                }
                if (($dieA == 1 || $dieB == 1) && !($dieA == 1 && $dieB == 1)){
                        say "No score this roll, end of turn";
                        sleep 1;
                        $endTurn = 1;
                }
                if (($dieA == $dieB) && !($dieA == 1 && $dieB == 1)){
                        $turnScore = $turnScore + $dieA + $dieB;
                        say "Doubles! Auto Roll!!";
                        sleep 1;
                }
        }
}
