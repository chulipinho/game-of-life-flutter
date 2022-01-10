import 'package:flutter/foundation.dart';

class Cell {
  int row;
  int col;
  final state = ValueNotifier<bool>(false);

  Cell(this.row, this.col);

  bool get isAlive => state.value;
  die() => state.value = false;
  live() => state.value = true;
}
