\d .moves
//line of sight function to identify up what point can move in a direction
los:{fe:(y[x] in .Q.A)?1b;x where (&\) -1 _ @[;fe;:;1b] null[y x],0b}
//applymove - x-board, y-starting co-ord, z-new co-ord
ap:{p:x y;
	x:@[x;enlist y;:;" "];
	@[x;enlist z;:;p]}
//fuctions for each piece x - co-ord, y - board
p:{r3:();
   if[r2:null y r:x+1 0;r3,:enlist r]; //simple single move forward
   if[[x[0]=1]&r2&null y r:x+2 0;r3,:enlist r]; //2 forward if nothin in the way and not moved yet 
   if[y[r:x+1 1] in .Q.A;r3,:enlist r]; //diagonal takes
   if[y[r:x+1 -1] in .Q.A;r3,:enlist r];
   //TODO add enpassant - dependant on last move. lood at history? set global when making move that allows move 
   r4:ap[y;x;] each r3; 
   raze {$[7=first y;@[y;enlist x;:;] each "rnbq";enlist y]}'[r3;r4] //promtions  
   }
n:{res:x+/:raze (1 1;-1 1;1 -1;-1 -1)*\:/:(1 2;2 1);
   res@: where null[y res] or y[res] in .Q.A;
   res:inter[;key y] res;
   ap[y;x;] each res 
   }
r:{res:(asc key[y]where 1=sum flip key[y]=\:x); //find vert/horiz lines
   res2:los[;y] res where res[;0]>x 0;
   res2,:los[;y] res where res[;1]>x 1;
   res2,:los[;y] reverse res where res[;0]<x 0;
   res2,:los[;y] reverse res where res[;1]<x 1;
   ap[y;x;] each res2
   }
b:{is:1+til 6;
  res:los[;y] inter[;key y] x+/:is,'is;
  res,:los[;y] inter[;key y] x+/:is,'neg is;
  res,:los[;y] inter[;key y] x+/:neg[is],'neg is;
  res,:los[;y] inter[;key y] x+/:neg[is],'is;
  ap[y;x;] each res
  }
q:{r[x;y],b[x;y]}
k:{r:raze los[;y] each enlist each inter[;key y] x+/:1_{x cross x} 0 1 -1;
  :r:ap[y;x;] each r; 
  ///TODO add castling 
  //1 -has king moved, 2-has rock moved,2-is king currently in check,3-clear path,4-are two squares king moves through being attacked
  }
\d .
