import 'package:flutter/material.dart';
import 'package:game_of_life/board/board_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: BoardWidget(rows: 20, columns: 20)),
    );
  }
}
