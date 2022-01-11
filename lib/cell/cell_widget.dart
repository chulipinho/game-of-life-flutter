import 'package:flutter/material.dart';
import 'package:game_of_life/cell/cell.dart';
import 'package:game_of_life/core/app_colors.dart';

class CellWidget extends StatefulWidget {
  final Cell cell;
  const CellWidget({Key? key, required this.cell}) : super(key: key);

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  void killCell() => widget.cell.die();
  void reviveCell() => widget.cell.live();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.cell.state,
        builder: (context, value, _) {
          return InkWell(
            enableFeedback: false,
            onTap: () {
              if (widget.cell.isAlive) {
                killCell();
              } else {
                reviveCell();
              }
              setState(() {});
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                color: widget.cell.isAlive
                    ? AppColors.aliveCell
                    : AppColors.deadCell,
              ),
            ),
          );
        });
  }
}
