import 'package:flutter/material.dart';

import '../model/misc.dart';

import '../constants/constants.dart';

class Stone extends StatelessWidget {
  final StoneType _type;
  final double _size;
  final String _text;

  Stone({StoneType type, double size, String text})
      : _type = type,
        _size = size,
        _text = text;

  @override
  Widget build(BuildContext context) {
    if (_type == StoneType.empty) return new Container();
    Color stoneColor = _type == StoneType.white ? Colors.white : Colors.black;
    Color textColor = _type == StoneType.white ? Colors.black : Colors.white;
    double stoneSize = _size == null ? GameConfig.defaultStoneSize : _size;

    return Container(
      width: stoneSize,
      height: stoneSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: stoneColor,
      ),
      child: _text != null
          ? Text(
              _text,
              style: TextStyle(
                fontSize: stoneSize * GameConfig.scoreStoneTextRatio,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            )
          : null,
    );
  }
}
