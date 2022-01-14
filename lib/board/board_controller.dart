import 'dart:async';

import 'package:game_of_life/board/utils/history_manager.dart';
import 'package:game_of_life/cell/cell.dart';

class BoardController {
  final int rows;
  final int columns;
  late Timer _timer;
  final history = HistoryManager(maxUndos: 50);

  BoardController(this.rows, this.columns);

  bool get isHistoryEmpty => history.boardHistory.isEmpty;

  List<List<Cell>> boardData = [];
  List<List<bool>> newBoardState = [];

  void _createStateBackup() {
    newBoardState = [];
    for (int x = 0; x < rows; x++) {
      newBoardState.add([]);
      for (int y = 0; y < columns; y++) {
        newBoardState[x].add(boardData[x][y].isAlive);
      }
    }
    history.addToHistory(newBoardState);
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
    } else {
      return true;
    }
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
      if (newBoardState[cell.row][cell.col] && !cell.isAlive) {
        cell.live();
      } else if (!newBoardState[cell.row][cell.col] && cell.isAlive) {
        cell.die();
      }
    });
  }

  void _manageCellState(Cell cell) {
    int neighborsAlive = _aliveNeighbors(cell);

    newBoardState[cell.row][cell.col] =
        _manageBackupState(neighborsAlive) ?? newBoardState[cell.row][cell.col];
  }

  void runCycle() {
    _createStateBackup();
    _makeAllCells(_manageCellState);
    _updateBoard();
  }

  void runCycles() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      runCycle();
    });
  }

  void stopCycles() {
    if (_timer.isActive) {
      _timer.cancel();
    }
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
    _makeAllCells("randomize");
    _createStateBackup();
  }

  void undo() {
    final previousBoardState = history.pop();

    _makeAllCells((Cell cell) {
      boardData[cell.row][cell.col].state.value =
          previousBoardState[cell.row][cell.col];
    });
  }
}
