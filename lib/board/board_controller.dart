import 'package:game_of_life/cell/cell.dart';

class BoardController {
  final int rows;
  final int columns;

  BoardController(this.rows, this.columns);

  List<List<Cell>> boardData = [];

  List<Cell> aliveCells = [];

  void _manageCellData(Cell cell) {
    if (cell.isAlive){
      aliveCells.add(cell);
    }else if (aliveCells.contains(cell)){
      aliveCells.remove(cell);
    }
  }
  
  void init() {
    for (int x = 0; x < rows; x++){
      for (int y = 0; y < columns; y++){
        boardData[x][y] = Cell(x, y);
        boardData[x][y].state.addListener(() => _manageCellData(boardData[x][y]));
      }
    }
  }
  
  void runCycle(){
    
  }

}