class HistoryManager {
  final int maxUndos;
  List<List<List<bool>>> boardHistory = [];

  HistoryManager({required this.maxUndos});

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
  }

  List<List<bool>> pop() {
    return boardHistory.removeLast();
  }
}
