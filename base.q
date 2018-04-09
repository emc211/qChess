//pieces captial black lower white
pieces:"RNBKQBNRPPPPPPPPrnbqkbnrpppppppp"
//starting board
sboard:((raze abs 63 0-\:til 16)!pieces) 8 cut til 8*8
//board as a dictionary
is:({x cross x} til 8)
dboard:is!sboard ./:is
switch:{key[x]!raze ((.Q.a!.Q.A),.Q.A!.Q.a) reverse showboard x}
//utility functions  
showboard:{8 cut value x} //visualise dict board 
testboard:{@[key[dboard]!count[dboard]#" ";3 4;:;x]} //place piece x in cetner of board 
pmoves:{moves[`$y x][x;y]}
/moves for each piece
\l moves.q
newBoards:{p:y z;y:@[y;enlist z;:;" "];@[y;enlist x;:;p]}
outcomes:{newBoards[;y;x] each pmoves[x;y]}
possibleBoards:{raze outcomes[;x] each where x in lower pieces}
//find players potential return boards 
//({raze outcomes[;x] each where x in lower pieces} testboard"r")
/start mapping of boards to potential next boards
mapping:enlist[dboard]!enlist raze outcomes[;dboard] each where dboard in lower pieces
//keep adding to mapping
mapping,:new!possibleBoards each new:except[;key mapping]raze value mapping
//play game against algo
algo:{first 1?raze outcomes[;x] each where x in lower pieces} 
//nicer visual
vdict:"12345678ABCDEFGH"!7 6 5 4 3 2 1 0 0 1 2 3 4 5 6 7
vdisp:{raze ("87654321",'(8#" "),'x;enlist "  ABCDEFGH")}
newGame:{vdisp showboard board::dboard}
move:{[b;op;np] op:vdict op;np:vdict np;p:b op;b:@[b;op;:;" "];b:@[b;np;:;p];vdisp showboard board::algo[b]}
board:dboard;
play:{move[value `board;x;y]};
0N!"STARTING BOARD";
`$vdisp showboard board
0N!`$"To Play run 'play[oldPosition;newPositsion] .e.g play[\"2D\";\"3D\"]";
