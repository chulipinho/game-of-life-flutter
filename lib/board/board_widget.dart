import 'package:flutter/material.dart';
import 'package:game_of_life/cell/cell_widget.dart';

class BoardWidget extends StatefulWidget {
  final int rows;
  final int columns;
  const BoardWidget({Key? key, required this.rows, required this.columns})
      : super(key: key);

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.columns,
        (col) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.rows,
            (row) => CellWidget(col: col, row: row),
          ),
        ),
      ),
    );
  }
}
