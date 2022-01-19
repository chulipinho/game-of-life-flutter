import 'dart:async';

import 'package:game_of_life/board/utils/history_manager.dart';
import 'package:game_of_life/cell/cell.dart';

class BoardController {
  final int rows;
  final int columns;
  final history = HistoryManager(maxUndos: 50);
  Timer _timer = Timer(Duration.zero, () {});

  BoardController(this.rows, this.columns);

  bool get isHistoryEmpty => history.boardHistory.isEmpty;
  bool get boardIsEmpty {
    for (List<Cell> cells in boardData) {
      for (Cell cell in cells) {
        if (cell.isAlive) return false;
      }
    }
    return true;
  }

  List<List<Cell>> boardData = [];
  List<List<bool>> boardState = [];

  void _createStateBackup() {
    bool isRepeating = true;
    boardState = [];

    for (int x = 0; x < rows; x++) {
      boardState.add([]);
      for (int y = 0; y < columns; y++) {
        boardState[x].add(boardData[x][y].isAlive);

        if (history.previousValue == null) {
          isRepeating = false;
        } else if (boardState[x][y] != history.previousValue![x][y]) {
          isRepeating = false;
        }
      }
    }

    if (isRepeating) {
      stopCycles();
      return;
    }

    history.addToHistory(boardState);
  }

  void init() {
    for (int x = 0; x < rows; x++) {
      boardData.add([]);
      for (int y = 0; y < columns; y++) {
        boardData[x].add(Cell(row: x, col: y));
      }
    }
  }

  bool _isIndexOutOfRange(int x, int y) {
    if (x >= 0 && x < rows && y >= 0 && y < columns) {
      return false;
    }
    return true;
  }

  int _aliveNeighbors(Cell cell) {
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

  bool? _manageBackupState(int neighbors) {
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

  void _updateBoard() {
    _makeAllCells((cell) {
      if (boardState[cell.row][cell.col] && !cell.isAlive) {
        cell.live();
      } else if (!boardState[cell.row][cell.col] && cell.isAlive) {
        cell.die();
      }
    });
  }

  void _manageCellState(Cell cell) {
    int neighborsAlive = _aliveNeighbors(cell);

    boardState[cell.row][cell.col] =
        _manageBackupState(neighborsAlive) ?? boardState[cell.row][cell.col];
  }

  void runCycle() {
    _createStateBackup();
    _makeAllCells(_manageCellState);
    _updateBoard();
  }

  void runCycles() {
    if (boardIsEmpty) return;
    if (_timer.isActive) return;

    _timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      runCycle();
    });
  }

  void stopCycles() {
    _timer.cancel();
  }

  void clearBoard() {
    _makeAllCells("die");
    history.clearHistory();
    stopCycles();
  }

  void _makeAllCells(command) {
    for (List<Cell> cells in boardData) {
      for (Cell cell in cells) {
        if (command is String) {
          cell[command];
        } else {
          command(cell);
        }
      }
    }
  }

  void randomize() {
    _timer.cancel();
    _makeAllCells("randomize");
    // _createStateBackup();
  }

  void undo() {
    var previousboardState = history.pop();
    bool isRepeated = true;

    for (int x = 0; x < rows; x++) {
      for (int y = 0; y < columns; y++) {
        if (previousboardState[x][y] != boardState[x][y]) {
          isRepeated = false;
        }
      }
      if (!isRepeated) break;
    }

    if (isRepeated) previousboardState = history.pop();

    _makeAllCells((Cell cell) {
      boardData[cell.row][cell.col].state.value =
          previousboardState[cell.row][cell.col];
    });
  }
}
