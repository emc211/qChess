//This scrip will define the function algo that will take a board and output a a board with a new move

//Random - randomly select one of any legal moves 
randomAlgo:{first 1?legalBoards x}

//ML- Here will start to add inteligence to make decisions about moves 
//start mapping of boards to potential next boards
/mapping:enlist[startingBoard]!enlist legalBoards startingBoard
//keep adding to mapping
/mapping,:new!legalBoards each new:except[;key mapping]raze value mapping

//Scoring Board
scoreBoard:"kqrbnp"!neg 0W 7 5 3 3 1;
scoreBoard,:(upper key scoreBoard)!neg value scoreBoard;
score:{if[0h~type x;:.z.s each x];sum scoreBoard x}
scoringAlgo:{c s?max s:sum each scoreBoard c:legalBoards x}
oneLookAhead:{p first 1?where r=max r:raze {min score each legalBoards switch x} each p:legalBoards x}

scoreChoices:{score each legalBoards switch x}
lookAhead:{chcs:legalBoards x;legalBoards switch chcs }


algo:oneLookAhead
