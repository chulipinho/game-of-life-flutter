import 'package:flutter/material.dart';
import 'package:game_of_life/board/board_controller.dart';
import 'package:game_of_life/shared/default_button_widget.dart';
import 'package:game_of_life/shared/dynamic_button_widget.dart';

class ButtonPadWidget extends StatelessWidget {
  final BoardController controller;
  const ButtonPadWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconSize = 40;

    return Column(children: [
      SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DefaultButtonWidget(
              onTap: () {},
              child: Icon(
                Icons.keyboard_arrow_left_rounded,
                size: iconSize,
              ),
            ),
            DefaultButtonWidget(
              onTap: () {},
              child: Icon(
                Icons.close_rounded,
                size: iconSize,
              ),
            ),
            DefaultButtonWidget(
              onTap: () {},
              child: Icon(
                Icons.play_arrow_rounded,
                size: iconSize,
              ),
            ),
            DefaultButtonWidget(
              onTap: () {},
              child: Icon(
                Icons.keyboard_arrow_right_rounded,
                size: iconSize,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 16,
      ),
      DefaultButtonWidget(
        onTap: controller.randomize,
        child: Text(
          "Randomize",
          style: TextStyle(fontSize: iconSize / 2),
        ),
        width: 200,
        height: 40,
      )
    ]);
  }
}
