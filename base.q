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
lineOfSight:{[ks;board] ks where (&\)null[board ks] or board[ks] in .Q.A}
moves.p:{
	if[blk:y[x]<>lower y x;y:reverse reverse each y];
	res:$[r2:null y r:x+1 0;enlist r;()];
	res,:$[[x[0]=1]&r2&null y r:x+2 0;enlist r;()];
	res,:$[y[r:x+1 1] in .Q.A;enlist r;()];
	res,:$[y[r:x+1 -1] in .Q.A;enlist r;()];
	if[blk;res];
	inter[;key y] res
	}
moves.n:{
	res:x+/:raze (1 1;-1 1;1 -1;-1 -1)*\:/:(1 2;2 1);
	res@: where null[y res] or y[res] in .Q.A;
	inter[;key y] res 
	}
moves.r:{res:(asc key[y]where 1=sum flip key[y]=\:x);
	res2:lineOfSight[;y] res where res[;0]>x 0;
	res2,:lineOfSight[;y] res where res[;1]>x 1;
        res2,:lineOfSight[;y] reverse res where res[;0]<x 0;
	res2,:lineOfSight[;y] reverse res where res[;1]<x 1;
	res2
	}
moves.b:{is:1+til 6;
        res:lineOfSight[;y] inter[;key y] x+/:is,'is;
	res,:lineOfSight[;y] inter[;key y] x+/:is,'neg is;
	res,:lineOfSight[;y] inter[;key y] x+/:neg[is],'neg is;
	res,:lineOfSight[;y] inter[;key y] x+/:neg[is],'is;
	res
	}
moves.q:{moves.r[x;y],moves.b[x;y]}
moves.k:{
	res:raze lineOfSight[;y] each enlist each inter[;key y] x+/:1_{x cross x} 0 1 -1;
	res
	}

newBoards:{p:y z;y:@[y;enlist z;:;" "];@[y;enlist x;:;p]}
outcomes:{newBoards[;y;x] each pmoves[x;y]}
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
play::move[board];
0N!"STARTING BOARD";
`$vdisp showboard board
0N!`$"To Play run 'play[oldPosition;newPositsion] .e.g play[\"2D\";\"3D\"]";
