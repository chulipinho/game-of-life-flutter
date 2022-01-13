import 'dart:math';

import 'package:flutter/foundation.dart';

class Cell {
  final int row;
  final int col;
  final state = ValueNotifier<bool>(false);

  Cell({required this.row, required this.col});

  operator [](param) {
    switch (param) {
      case "die":
        die();
        break;
      case "live":
        live();
        break;
      case "randomize":
        randomizeState();
        break;
    }
  }

  bool get isAlive => state.value;
  die() => state.value = false;
  live() => state.value = true;

  randomizeState() {
    state.value = Random().nextBool();
  }
}
