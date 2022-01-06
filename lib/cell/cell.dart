class Cell {
  int row;
  int col;
  bool _isAlive = false;

  Cell(this.row, this.col);

  bool get isAlive => _isAlive;
  die() => _isAlive = false;
  live() => _isAlive = true;
}
