import 'package:flutter/material.dart';

enum ItemStateType { All, Friendship, Desactivated }

class StateItem extends StatefulWidget {
  final ItemStateType stateType;
  final Function(ItemStateType)? callback;
  final Size size;
  final debugMode;

  StateItem(
      {this.size = const Size(200, 35.0),
      this.stateType = ItemStateType.All,
      this.callback,
      this.debugMode = false});

  @override
  State<StatefulWidget> createState() {
    return _StateItem(
        size: size,
        stateType: stateType,
        callback: callback,
        debugMode: debugMode);
  }
}

class _StateItem extends State<StateItem> {
  Size size;
  ItemStateType stateType;
  final Function(ItemStateType)? callback;

  _StateItem(
      {this.size = const Size(200.0, 35.0),
      this.stateType = ItemStateType.All,
      this.callback,
      this.debugMode = false});

  late Color _iconStatusColor;
  late String _text;

  bool debugMode;

  @override
  void initState() {
    super.initState();

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
    double textSpaceWidth = size.width * 0.95; // 90%
    double iconSpaceWidth = size.width * 0.05; // 10%

    return Container(
        width: size.width,
        height: size.height,
        color: debugMode ? Color(0x22222222) : null,
        child: Row(
          children: [
            // state icon
            Container(
                color: debugMode ? Color(0x3300FF000) : null,
                width: iconSpaceWidth,
                child: Center(
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _iconStatusColor,
                          ),
                        )))),
            Container(
                color: debugMode ? Color(0x330000FF) : null,
                width: textSpaceWidth,
                child: Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: SizedBox(
                        height: size.height / 2,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(_text,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ))))
          ],
        ));
  }
}
