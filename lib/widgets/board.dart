import 'package:flutter/material.dart';

import 'board_cell.dart';

import '../model/board_model.dart';
import '../model/misc.dart';

import '../constants/constants.dart';

typedef CoordinatesCallback = void Function(BoardCoordinates);

class Board extends StatelessWidget {
  final BoardModel _model;
  final CoordinatesCallback _onTapCell;

  Board({BoardModel model, CoordinatesCallback onTapCell})
      : _model = model,
        _onTapCell = onTapCell;

  @override
  Widget build(BuildContext context) {
    if (!_model.isValid()) return Container();
    
    return Container(
      padding: EdgeInsets.all(GameConfig.boardPadding),
      decoration: BoxDecoration(
        color: GameConfig.boardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          _model.size,
          (x) => Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  _model.size,
                  (y) => BoardCell(
                        stoneType: _model.getAt(BoardCoordinates(x, y)),
                        onPressed: () => _onTapCell(BoardCoordinates(x, y)),
                      ),
                ),
              ),
        ),
      ),
    );
  }
}
