import '../model/misc.dart';

import '../constants/constants.dart';

List<List<StoneType>> getNewBoard(size) {
  if (size < 3) return null;
  final start = (size / 2).floor() - 1;
  final end = size % 2 == 0 ? start + 1 : start + 2;
  return List.generate(
    size,
    (x) => List.generate(size, (y) {
          if (x < start || x > end || y < start || y > end)
            return StoneType.empty;
          return (x + y) % 2 == 1 ? StoneType.black : StoneType.white;
        }),
  );
}

class BoardModel {
  int _size;
  StoneType _currentStone;
  List<List<StoneType>> _boardMap;

  BoardModel({int boardSize})
      : _size = boardSize,
        _currentStone = StoneType.black,
        _boardMap = getNewBoard(boardSize);

  int get size => _size;

  StoneType get currentStone => _currentStone;

  StoneType getAt(BoardCoordinates pos) => _boardMap[pos.x][pos.y];

  StoneType setAt(BoardCoordinates pos, StoneType type) =>
      _boardMap[pos.x][pos.y] = type;

  int get blackCount {
    List<StoneType> allStones = _boardMap.expand((column) => column).toList();
    return allStones.where((stone) => stone == StoneType.black).length;
  }

  int get whiteCount {
    List<StoneType> allStones = _boardMap.expand((column) => column).toList();
    return allStones.where((stone) => stone == StoneType.white).length;
  }

  bool get isGameOver =>
      whiteCount + blackCount == _size * _size ||
      whiteCount + blackCount == whiteCount ||
      whiteCount + blackCount == blackCount;

  StoneType get winner {
    if (!isGameOver) return null;
    if (blackCount > whiteCount || whiteCount + blackCount == blackCount)
      return StoneType.black;
    if (blackCount < whiteCount || whiteCount + blackCount == whiteCount)
      return StoneType.white;
    return StoneType.empty;
  }

  List<BoardCoordinates> _getFlipsByVector(
      BoardCoordinates pos, BoardVector vector) {
    final result = List<BoardCoordinates>();
    int currentX = pos.x, currentY = pos.y;

    void advance() {
      currentX += vector.deltaX;
      currentY += vector.deltaY;
    }

    advance();
    while (currentX > -1 &&
        currentX < _size &&
        currentY > -1 &&
        currentY < _size) {
      StoneType thisStone = _boardMap[currentX][currentY];
      if (thisStone == _currentStone) {
        return result;
      } else if (thisStone == StoneType.empty) {
        return [];
      } else {
        result.add(BoardCoordinates(currentX, currentY));
        advance();
      }
    }
    return [];
  }

  void _flipStones(List<BoardCoordinates> coordinates) {
    coordinates.forEach((pos) => _boardMap[pos.x][pos.y] = _currentStone);
  }

  void _flipCurrentStone() {
    if (_currentStone == StoneType.black)
      _currentStone = StoneType.white;
    else
      _currentStone = StoneType.black;
  }

  bool putStone(BoardCoordinates pos) {
    if (getAt(pos) != StoneType.empty) return false;

    final flipList = List<BoardCoordinates>();
    FLIP_VECTOR_LIST.forEach((vector) {
      flipList.addAll(_getFlipsByVector(pos, vector));
    });

    if (flipList.isEmpty == true) return false;
    flipList.add(pos);

    _flipStones(flipList);
    _flipCurrentStone();

    return true;
  }

  void skipTurn() {
    _flipCurrentStone();
  }

  bool isValid() => _boardMap != null;
}
