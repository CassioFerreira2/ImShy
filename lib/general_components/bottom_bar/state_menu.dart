import 'package:flutter/material.dart';
import 'package:imshy/general_components/bottom_bar/state_item.dart';

class StateMenu extends StatefulWidget {
  @override
  _StateMenu createState() => _StateMenu();
}

class _StateMenu extends State<StateMenu> {
  late GlobalKey _keyMainItem;
  late OverlayEntry _overlayEntry;

  late Offset _mainItemPosition;
  late Size _mainItemSize;

  @override
  void initState() {
    super.initState();

    _keyMainItem = LabeledGlobalKey("item_main");
  }

  bool _openned = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StateItem(
        key: _keyMainItem,
        callback: (_) {
          _mainItemClicked();
        },
      ),
    );
  }

  void _mainItemClicked() {
    if (!_openned) {
      _findMainItem();
      _overlayEntry = _overlayEntryBuilder();
      Overlay.of(context)?.insert(_overlayEntry);
    } else {
      _overlayEntry.remove();
    }

    _openned = !_openned;
  }

  void _stateItemClicked(ItemStateType state) {}

  void _findMainItem() {
    RenderBox box =
        _keyMainItem.currentContext?.findRenderObject() as RenderBox;

    _mainItemPosition = box.localToGlobal(Offset.zero);
    _mainItemSize = box.size;
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
            bottom: _mainItemSize.height,
            left: _mainItemPosition.dx,
            width: _mainItemSize.width,
            child: Material(color: Colors.transparent, child: _buildItens()));
      },
    );
  }

  Widget _buildItens() => Column(
        children: [
          StateItem(stateType: ItemStateType.All, callback: _stateItemClicked),
          StateItem(
              stateType: ItemStateType.Friendship, callback: _stateItemClicked),
          StateItem(
              stateType: ItemStateType.Desactivated,
              callback: _stateItemClicked),
        ],
      );
}
