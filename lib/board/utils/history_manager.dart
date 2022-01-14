import 'package:flutter/cupertino.dart';

class HistoryManager {
  final int maxUndos;
  final empty = ValueNotifier<bool>(true);
  List<List<List<bool>>> boardHistory = [];

  HistoryManager({required this.maxUndos});

  bool get isEmpty => empty.value;

  List<List<bool>> _unreferenceList(List<List<bool>> lists) {
    List<List<bool>> unreferencedList = [];

    for (List list in lists) {
      unreferencedList.add([...list]);
    }

    return unreferencedList;
  }

  void addToHistory(List<List<bool>> value) {
    final unreferencedValue = _unreferenceList(value);

    boardHistory.add(unreferencedValue);

    if (boardHistory.length > maxUndos) {
      boardHistory.removeAt(0);
    }
    if (empty.value) empty.value = false;
  }

  List<List<bool>> pop() {
    final pop = boardHistory.removeLast();

    if (boardHistory.isEmpty) empty.value = true;

    return pop;
  }

  void clearHistory() {
    boardHistory.clear();
    if (boardHistory.isEmpty) empty.value = true;
  }
}
