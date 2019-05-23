import 'dart:math';
import 'package:flutter/material.dart';

import 'stone.dart';

import '../model/misc.dart';

import '../constants/constants.dart';

class Footer extends StatelessWidget {
  final StoneType _currentStone;
  final StoneType _winner;

  Footer({StoneType currentStone, StoneType winner})
      : _currentStone = currentStone,
        _winner = winner;

  String _getMessage() {
    if (_winner == null) return 'Current Move  ';
    if (_winner != StoneType.empty) return 'Winner  ';
    return 'Round Draw!';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final StoneType stoneType = _winner == null ? _currentStone : _winner;
    final Color textColor =
        stoneType == StoneType.black ? Colors.black : Colors.white;

    return Container(
      padding: FooterTheme.padding,
      color: FooterTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _getMessage(),
            style: FooterTheme.text.copyWith(
              color: textColor,
              fontSize: min(
                screenWidth * GameConfig.footerFontRatio,
                GameConfig.footerFontMaxSize,
              ),
            ),
          ),
          if (stoneType != StoneType.empty) Stone(type: stoneType),
        ],
      ),
    );
  }
}
