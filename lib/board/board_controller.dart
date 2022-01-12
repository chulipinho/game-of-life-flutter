import 'package:game_of_life/cell/cell.dart';

class BoardController {
  final int rows;
  final int columns;

  BoardController(this.rows, this.columns);

  List<List<Cell>> boardData = [[]];
  List<List<bool>> newBoardState = [[]];

  void createStateBackup() {
    newBoardState = [[]];
    for (int x = 0; x < rows; x++) {
      newBoardState.add([]);
      for (int y = 0; y < columns; y++) {
        newBoardState[x].add(boardData[x][y].isAlive);
      }
    }
  }

  void init() {
    for (int x = 0; x < rows; x++) {
      boardData.add([]);
      for (int y = 0; y < columns; y++) {
        boardData[x].add(Cell(x, y));
      }
    }
  }

  bool _isIndexOutOfRange(int x, int y) {
    if (x >= 0 && x < rows && y >= 0 && y < columns) {
      return false;
    } else {
      return true;
    }
  }

  int aliveNeighbors(Cell cell) {
    int aliveNeighbours = 0;

    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        int row = x + cell.row;
        int col = y + cell.col;

        //Checks if cell is not itself
        if (x == 0 && y == 0) {
          continue;
        }

        if (!_isIndexOutOfRange(row, col)) {
          if (boardData[row][col].isAlive) {
            aliveNeighbours++;
          }
        }
      }
    }
    return aliveNeighbours;
  }

  bool? manageBackupState(int neighbors) {
    if (neighbors > 3 || neighbors < 2) {
      return false;
    }
    if (neighbors == 3) {
      return true;
    }
    if (neighbors == 2) {
      return null;
    }
  }

  void manageCellState() {
    for (List<Cell> cells in boardData) {
      for (Cell cell in cells) {
        if (newBoardState[cell.row][cell.col] && !cell.isAlive) {
          cell.live();
        } else if (!newBoardState[cell.row][cell.col] && cell.isAlive) {
          cell.die();
        }
      }
    }
  }

  void runCycle() {
    createStateBackup();
    for (List<Cell> cells in boardData) {
      for (Cell cell in cells) {
        int neighborsAlive = aliveNeighbors(cell);

        newBoardState[cell.row][cell.col] = manageBackupState(neighborsAlive) ??
            newBoardState[cell.row][cell.col];
      }
    }
    manageCellState();
  }

  void testFunc() {
    runCycle();
  }
}
