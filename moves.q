\d .moves
//line of sight function to identify up what point can move in a direction
los:{x where (&\)null[y x] or y[x] in .Q.A}
//applymove - x-board, y-starting co-ord, z-new co-ord
ap:{[x;y;z]p:x y;x:@[x;enlist y;:;" "];@[x;enlist z;:;p]}
//fuctions for each piece x - co-ord, y - board
p:{r3:();
   r3:$[r2:null y r:x+1 0;enlist r;()]; //simple single move forward
   r3,:$[[x[0]=1]&r2&null y r:x+2 0;enlist r;()]; //2 forward if nothin in the way and not moved yet 
   r3,:$[y[r:x+1 1] in .Q.A;enlist r;()]; //diagonal takes
   r3,:$[y[r:x+1 -1] in .Q.A;enlist r;()];
   r4:ap[y;x;] each r3; //TODO add enpassant - maybe store boolean .moves.enpass need to be set by algo/play when chosing move
   raze {[r3;r4;i] $[7=first r3 i;@[r4 i;enlist r3 i;:;] each "rnbq";enlist r4 i]}[r3;r4] each til count r4 //promtions  
   }
n:{res:x+/:raze (1 1;-1 1;1 -1;-1 -1)*\:/:(1 2;2 1);
   res@: where null[y res] or y[res] in .Q.A;
   res:inter[;key y] res;
   ap[y;x;] each res 
   }
r:{res:(asc key[y]where 1=sum flip key[y]=\:x); //find diagnoal lines
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
