//This scrip will define the function algo that will take a board and output a a board with a new move

//Random - randomly select one of any legal moves 
algo:{first 1?legalBoards x}

//ML- Here will start to add inteligence to make decisions about moves 
//start mapping of boards to potential next boards
mapping:enlist[startingBoard]!enlist legalBoards startingBoard
//keep adding to mapping
mapping,:new!legalBoards each new:except[;key mapping]raze value mapping

