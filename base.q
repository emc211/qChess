//CHESS FRAME WORK
//Original verion Eoin Cunning - March 2018

//pieces captial black lower white
aPieces:"RNBKQBNRPPPPPPPPrnbqkbnrpppppppp"
//lowerPieces
lPieces:"rnbqkbnrpppppppp"
//starting board
sboard:((raze abs 63 0-\:til 16)!aPieces) 8 cut til 8*8
//board as a dictionary
is:({x cross x} til 8)
dboard:is!sboard ./:is
//piece Dictionary 
pDict:{(X!x),x!X:upper x} lPieces
//matrix board
mBoard:{8 cut value x} 
//switch the board to view as opposite user
switch:{key[x]!raze pDict reverse mBoard x}
//utility functions  
testboard:{@[key[dboard]!count[dboard]#" ";3 4;:;x]} //place piece x in cetner of board 
//load moves for each piece
\l moves.q
//evaluate what piece is to get correct piece function then pass it board and key for that piece 
pmoves:{.moves[`$y x][x;y]}
//given board starting co-ord and new co-ord provide outcome board
newBoards:{p:y z;y:@[y;enlist z;:;" "];@[y;enlist x;:;p]}
//the outcomes possible from a piece's move 
outcomes:{newBoards[;y;x] each pmoves[x;y]}
//find all possible boards
possibleBoards:{raze r where 0<>count each r:outcomes[;x] each where x in lPieces}
//check defined as when oppositions next possible move results in no king
isCheck:{not all "K" in/: possibleBoards switch x}
//can make any move that results in check
//dont need to check if check can never moved into a checked board
legalBoards:{r:possibleBoards x;$[isCheck x;r where not isCheck each r;r]}

//ML- Here will start to add inteligence to make decisions about moves 
//currenty just picks random move
//start mapping of boards to potential next boards
mapping:enlist[dboard]!enlist legalBoards dboard 
//keep adding to mapping
mapping,:new!legalBoards each new:except[;key mapping]raze value mapping
//play game against algo
algo:{first 1?legalBoards x} 

//Visual to play on cmd line
vdict:"12345678ABCDEFGH"!7 6 5 4 3 2 1 0 0 1 2 3 4 5 6 7
vdisp:{raze ("87654321",'(8#" "),'x;enlist "  ABCDEFGH")}
showboard:{8 cut value x} //visualise dict board 
newGame:{vdisp showboard board::dboard}
move:{[b;op;np] op:vdict op;np:vdict np;p:b op;b:@[b;op;:;" "];b:@[b;np;:;p];vdisp showboard board::algo[b]}
board:dboard;
play:{move[value `board;x;y]};

//output starting board and instructions
0N!"STARTING BOARD";
`$vdisp showboard board
0N!`$"To Play run 'play[oldPosition;newPositsion] .e.g play[\"2D\";\"3D\"]";
