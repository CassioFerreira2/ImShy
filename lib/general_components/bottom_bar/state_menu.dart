import 'package:flutter/material.dart';
import 'package:imshy/general_components/bottom_bar/state_item.dart';

class StateMenu extends StatefulWidget {
  Function(ItemStateType state) stateChanged;

  StateMenu({Key? key, required this.stateChanged}) : super(key: key);

  @override
  _StateMenu createState() => _StateMenu(stateChanged: stateChanged);
}

class _StateMenu extends State<StateMenu> {
  Function(ItemStateType state) stateChanged;

  _StateMenu({required this.stateChanged});

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
    // Se o menu não estiver aberto insira fora da árvore o menu
    if (!_openned) {
      _findMainItem();
      _overlayEntry = _overlayEntryBuilder();
      Overlay.of(context)?.insert(_overlayEntry);
    } else {
      _overlayEntry.remove();
    }

    _openned = !_openned;
  }

  // Será chamado quando um dos itens de estado do menu forem
  // pressionados
  void _stateItemClicked(ItemStateType state) {}

  // Essa função é responsável por achar o item de estado principal,
  // que é aquele que esta na tela, ela faz isso usando a global key
  // que está vínculada ao item
  void _findMainItem() {
    RenderBox box =
        _keyMainItem.currentContext?.findRenderObject() as RenderBox;

    _mainItemPosition = box.localToGlobal(Offset.zero);
    _mainItemSize = box.size;
  }

  // Vai retornar nosso overlay (widget fora da árvore) que irá se sobrepor aos
  // outros, além disso já posiciona nossa coluna de itens para ficar acima
  // do item principal
  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
            bottom: _mainItemSize.height + 5,
            left: _mainItemPosition.dx,
            width: _mainItemSize.width,
            child: Material(color: Colors.transparent, child: _buildItens()));
      },
    );
  }

  // Vai apenas retornar uma coluna com cada item
  Widget _buildItens() => Column(
        children: [
          Divider(),
          StateItem(stateType: ItemStateType.All, callback: _stateItemClicked),
          Divider(),
          StateItem(
              stateType: ItemStateType.Friendship, callback: _stateItemClicked),
          Divider(),
          StateItem(
              stateType: ItemStateType.Desactivated,
              callback: _stateItemClicked),
        ],
      );
}
