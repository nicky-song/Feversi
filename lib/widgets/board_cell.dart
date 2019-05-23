import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'stone.dart';

import '../model/misc.dart';

import '../constants/constants.dart';

double getMaxCellSizeByScreenWidth(screenWidth) {
  const double boardSpace =
      (GameConfig.boardPadding + GameConfig.boardMargin) * 2;
  const double marginSpace =
      GameConfig.boardSize * GameConfig.boardCellMargin * 2;
  return (screenWidth - boardSpace - marginSpace) / GameConfig.boardSize;
}

class BoardCell extends StatefulWidget {
  final StoneType stoneType;
  final VoidCallback onPressed;

  BoardCell({StoneType stoneType, VoidCallback onPressed})
      : stoneType = stoneType,
        onPressed = onPressed;

  _BoardCellState createState() => _BoardCellState();
}

class _BoardCellState extends State<BoardCell>
    with SingleTickerProviderStateMixin {
  AnimationController _blinkController;
  Animation<Color> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      duration: const Duration(milliseconds: GameConfig.cellBlinkDuration),
      vsync: this,
    );
    _blinkAnimation = new ColorTween(
      begin: GameConfig.boardCellColor,
      end: GameConfig.boardCellHighlight,
    ).animate(_blinkController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _blinkController.reverse();
        }
      });
  }

  void _playTapAnimation() {
    if (widget.stoneType != StoneType.empty) return;
    _blinkController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double maxCellSize = getMaxCellSizeByScreenWidth(screenWidth);
    final double defaultCellSize =
        GameConfig.defaultStoneSize + GameConfig.boardCellPadding * 2;

    return GestureDetector(
      onTap: () {
        _playTapAnimation();
        widget.onPressed();
      },
      child: new AnimatedBuilder(
        animation: _blinkAnimation,
        builder: (context, child) => Container(
              constraints:
                  BoxConstraints(maxWidth: maxCellSize, maxHeight: maxCellSize),
              width: defaultCellSize,
              height: defaultCellSize,
              margin: EdgeInsets.all(GameConfig.boardCellMargin),
              padding: EdgeInsets.all(GameConfig.boardCellPadding),
              color: _blinkAnimation.value,
              alignment: Alignment.center,
              child: Stone(type: widget.stoneType),
            ),
      ),
    );
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }
}
