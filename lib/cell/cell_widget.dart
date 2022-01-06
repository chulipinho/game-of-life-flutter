import 'package:flutter/material.dart';
import 'package:game_of_life/cell/cell.dart';
import 'package:game_of_life/core/app_colors.dart';

class CellWidget extends StatefulWidget {
  final int row;
  final int col;
  const CellWidget({Key? key, required this.row, required this.col}) : super(key: key);

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {

  late Cell cell;

  @override
  void initState(){
    super.initState();
    cell = Cell(widget.row, widget.col);
  }

  void killCell() => cell.die();
  void reviveCell() => cell.live();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: () {
        if (cell.isAlive) {
          killCell();
        } else {
          reviveCell();
        }
        setState(() {
        });
      },
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          color: cell.isAlive ? AppColors.aliveCell : AppColors.deadCell,
        ),
      ),
    );
  }
}
