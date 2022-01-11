import 'package:game_of_life/cell/cell.dart';

class BoardController {
  final int rows;
  final int columns;

  BoardController(this.rows, this.columns);

  List<List<Cell>> boardData = [[]];
  List<List<Cell>> backupBoardData = [[]];

  void createBackup() {
    backupBoardData = boardData;
  }

  void init() {
    for (int x = 0; x < rows; x++) {
      boardData.add([]);
      for (int y = 0; y < columns; y++) {
        boardData[x].add(Cell(x, y));
      }
    }
  }

  bool isOutOfRange(int x, int y) {
    if (x > 0 && x < rows && y > 0 && y < columns) {
      return true;
    } else {
      return false;
    }
  }

  int aliveNeighbors(Cell cell) {
    int aliveNeighbours = 0;

    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        int row = x + cell.row;
        int col = y + cell.col;

        if (backupBoardData[row][col].isAlive && !isOutOfRange(row, col)) {
          aliveNeighbours++;
        }
      }
    }
    return aliveNeighbours;
  }

  void manageCellState(int neighbors, Cell cell) {
    if (neighbors > 3 || neighbors < 2) {
      if (cell.isAlive) {
        cell.die();
      }
      return;
    }
    if (!cell.isAlive) {
      cell.live();
    }
  }

  void runCycle() {
    createBackup();
    for (List<Cell> cells in boardData) {
      for (Cell cell in cells) {
        int neighborsAlive = aliveNeighbors(cell);

        manageCellState(neighborsAlive, cell);
      }
    }
  }
}
