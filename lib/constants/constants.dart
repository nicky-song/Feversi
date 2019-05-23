import 'package:flutter/material.dart';

import '../model/misc.dart';

class GameConfig {
  static const int primaryColor = 0xFF174378;
  static const double scoreStoneRatio = 0.14;
  static const double scoreStoneMaxSize = 72;
  static const double scoreStoneTextRatio = .5;
  static const double defaultStoneSize = 32.0;
  static const int boardSize = 8;
  static const double boardMargin = 12.0;
  static const double boardPadding = 10.0;
  static const Color boardColor = Color(0xFF555555);
  static const Color boardCellColor = Color(0xFF737373);
  static const Color boardCellHighlight = Color(0xFFCBCBCB);
  static const double boardCellMargin = 2.0;
  static const double boardCellPadding = 2.0;
  static const int cellBlinkDuration = 80;
  static const double footerFontRatio = 0.05;
  static const double footerFontMaxSize = 28;
}

class ScoreBoardTheme {
  static const backgroundColor = Color(0xFF737373);
  static const padding = EdgeInsets.all(10);
  static const text = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

class FooterTheme {
  static const backgroundColor = Color(0xFF737373);
  static const padding = EdgeInsets.only(top: 28, right: 20, bottom: 30, left: 20);
  static const text = const TextStyle(
    fontWeight: FontWeight.bold,
  );
}

const List<BoardVector> FLIP_VECTOR_LIST = const [
  BoardVector(0, -1), // Top
  BoardVector(1, -1), // Top-Right
  BoardVector(1, 0), // Right
  BoardVector(1, 1), // Bottom-Right
  BoardVector(0, 1), // Bottom
  BoardVector(-1, 1), // Bottom-Left
  BoardVector(-1, 0), // Left
  BoardVector(-1, -1), // Top-Left
];
