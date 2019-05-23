enum StoneType { empty, black, white }

class BoardCoordinates {
  final int x, y;

  const BoardCoordinates(this.x, this.y);
}

class BoardVector {
  final int deltaX, deltaY;

  const BoardVector(this.deltaX, this.deltaY);
}