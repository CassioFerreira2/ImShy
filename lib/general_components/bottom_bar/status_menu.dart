import 'package:flutter/material.dart';

enum ItemStateType { All, Friendship, Desactivated }

class StateItem extends StatelessWidget {
  final double width;
  final double height;
  final ItemStateType stateType;
  final Function(ItemStateType)? callback;

  double _offset = 2;

  // Member that need maths we initiliaze with instance!!
  late double _statusIconWidth;
  late double _statusIconHeight;
  late double _textLeft;

  late Color _iconStatusColor;
  late String _text;

  StateItem(
      {this.width = 200.0,
      this.height = 35.0,
      this.stateType = ItemStateType.All,
      this.callback}) {
    _statusIconWidth = width / 8;
    _statusIconHeight = height / 8;
    _textLeft = width / 6;

    switch (stateType) {
      case ItemStateType.All:
        _iconStatusColor = Colors.pink[400] ?? Colors.pink;
        _text = "Tudo";
        break;
      case ItemStateType.Friendship:
        _iconStatusColor = Colors.green;
        _text = "Amizade";
        break;
      default:
        _iconStatusColor = Colors.black87;
        _text = "Desativado";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: GestureDetector(
            onTap: () {
              callback?.call(stateType);
            },
            child: Stack(alignment: Alignment.center, children: [
              // status icon
              Positioned(
                width: _statusIconWidth,
                height: _statusIconHeight,
                left: _textLeft - _statusIconWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: _iconStatusColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Color(0xFF000000),
                          offset: Offset(0.0, 0.0)),
                    ],
                  ),
                  child: SizedBox.expand(),
                ),
              ),

              // text
              Positioned(
                left: _textLeft + _offset,
                child: Container(
                    decoration: BoxDecoration(),
                    child: Text(_text,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold))),
              ),

              // text
            ])));
  }
}
