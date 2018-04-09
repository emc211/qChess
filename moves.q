\d .moves
lineOfSight:{[ks;board] ks where (&\)null[board ks] or board[ks] in .Q.A}
p:{
        if[blk:y[x]<>lower y x;y:reverse reverse each y];
        res:$[r2:null y r:x+1 0;enlist r;()];
        res,:$[[x[0]=1]&r2&null y r:x+2 0;enlist r;()];
        res,:$[y[r:x+1 1] in .Q.A;enlist r;()];
        res,:$[y[r:x+1 -1] in .Q.A;enlist r;()];
        if[blk;res];
        inter[;key y] res
        }
n:{
        res:x+/:raze (1 1;-1 1;1 -1;-1 -1)*\:/:(1 2;2 1);
        res@: where null[y res] or y[res] in .Q.A;
        inter[;key y] res 
        }
r:{res:(asc key[y]where 1=sum flip key[y]=\:x);
        res2:lineOfSight[;y] res where res[;0]>x 0;
        res2,:lineOfSight[;y] res where res[;1]>x 1;
        res2,:lineOfSight[;y] reverse res where res[;0]<x 0;
        res2,:lineOfSight[;y] reverse res where res[;1]<x 1;
        res2
        }
b:{is:1+til 6;
        res:lineOfSight[;y] inter[;key y] x+/:is,'is;
        res,:lineOfSight[;y] inter[;key y] x+/:is,'neg is;
        res,:lineOfSight[;y] inter[;key y] x+/:neg[is],'neg is;
        res,:lineOfSight[;y] inter[;key y] x+/:neg[is],'is;
        res
        }
q:{moves.r[x;y],moves.b[x;y]}
k:{
        res:raze lineOfSight[;y] each enlist each inter[;key y] x+/:1_{x cross x} 0 1 -1;
        res
        }
\d .
