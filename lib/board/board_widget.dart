import 'package:flutter/material.dart';
import 'package:game_of_life/board/board_controller.dart';
import 'package:game_of_life/cell/cell_widget.dart';

class BoardWidget extends StatelessWidget {
  final int rows;
  final int columns;

  const BoardWidget({Key? key, required this.rows, required this.columns})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = BoardController(rows, columns);
    controller.init();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        columns,
        (col) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            rows,
            (row) => CellWidget(cell: controller.boardData[col][row]),
          ),
        ),
      ),
    );
  }
}
