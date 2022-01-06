import 'package:game_of_life/cell/cell.dart';

class Board {
  final int rows;
  final int columns;

  Board (this.rows, this.columns);

  List<Cell> aliveCells = [];
  
  
}