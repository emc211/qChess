### qChess 
##Chess Frame work in kdb
Original version EC - March 2018

To run execute `q base.q` on the cmd line
```
"################################"
"########## qChess ##############"
"################################"
"STARTING BOARD:"
"8 rnbqkbnr"
"7 pppppppp"
"6         "
"5         "
"4         "
"3         "
"2 PPPPPPPP"
"1 RNBQKBNR"
"  abcdefgh"
"################################"
`To Play run 'play[oldPosition;newPositsion]' .e.g play["2d";"3d"]
q)play["2d";"3d"]
"8 rnbqkbnr"
"7 pppp ppp"
"6     p   "
"5         "
"4         "
"3    P    "
"2 PPP PPPP"
"1 RNBQKBNR"
"  abcdefgh"
q)play["3d";"4d"]
"8 rnbqk nr"
"7 pppp ppp"
"6    bp   "
"5         "
"4    P    "
"3         "
"2 PPP PPPP"
"1 RNBQKBNR"
"  abcdefgh"
q)
```

Algo currently just select at random any legal move
Intention to change algo function to use either machine learning or board
evaluation to select moves in more advanced manor. 

Also potential to add a GUI to play 
