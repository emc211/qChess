//CHESS FRAME WORK
//Original version  EC - March 2018

//pieces captial black lower white
allPieces:"RNBKQBNRPPPPPPPPrnbqkbnrpppppppp"
//lowerPieces
lPieces:"rnbqkbnrpppppppp"
//starting board
sboard:((raze abs 63 0-\:til 16)!allPieces) 8 cut til 8*8
//board as a dictionary
startingBoard:is!sboard ./:is:{x cross x} til 8
//piece map
pMap:{(X!x),x!X:upper x} lPieces
//matricise board
mBoard:{8 cut value x} 
//switch the board to view as opponenet 
switch:{if[0h~type x;:.z.s each x];key[x]!raze pMap reverse mBoard x}

//load moves for each piece
\l moves.q
//the outcomes possible from a piece's move 
outcomes:{p:`$y x;
  .moves[p;x;y]
  }
castling:{[ind;board] :()} //place holder for castling take index and board eval if algo that will play as computer
promotion:{[boards] :boards} //place holder for promotion
//find all possible boards
possibleBoards:{raze r where 0<>count each r:outcomes[;x] each where x in lPieces}
//check defined as when oppositions next possible move results in no king
isCheck:{not all "K" in/: possibleBoards switch x}
//can make any move that results in check
//dont need to check if check can never moved into a checked board
legalBoards:{if[0h~type x;:.z.s each x];r:possibleBoards x;$[isCheck x;r where not isCheck each r;r]}

\l algo.q

//Visuals to play on cmd line
vdict:"12345678abcdefgh"!7 6 5 4 3 2 1 0 0 1 2 3 4 5 6 7
vdisp:{raze ("87654321",'(8#" "),'x;enlist "  abcdefgh")}
showboard:{8 cut value x} //visualise dict board 
newGame:{vdisp showboard board::startingBoard}
move:{[b;op;np] op:vdict op;np:vdict np;p:b op;b:@[b;op;:;" "];b:@[b;np;:;p];vdisp showboard board::algo[b]}
play:{move[value `board;x;y]};
//initialise  game
newGame`;
//output starting board and instructions
0N!"################################";
0N!"########## qChess ##############";
0N!"################################";
0N!"STARTING BOARD:";
0N!'vdisp showboard board;
0N!"################################";
0N!`$"To Play run 'play[oldPosition;newPositsion]' .e.g play[\"2d\";\"3d\"]";
