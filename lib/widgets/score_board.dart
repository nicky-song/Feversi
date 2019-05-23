import 'dart:math';
import 'package:flutter/material.dart';

import 'stone.dart';

import '../model/misc.dart';

import '../constants/constants.dart';

class ScoreBoard extends StatelessWidget {
  final int _whiteCount, _blackCount;

  ScoreBoard({int whiteCount, int blackCount})
      : _whiteCount = whiteCount,
        _blackCount = blackCount;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double stoneSize = min(
        screenWidth * GameConfig.scoreStoneRatio, GameConfig.scoreStoneMaxSize);

    return Container(
      padding: ScoreBoardTheme.padding,
      color: ScoreBoardTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stone(type: StoneType.white, size: stoneSize, text: '$_whiteCount'),
          Stone(type: StoneType.black, size: stoneSize, text: '$_blackCount'),
        ],
      ),
    );
  }
}
