import 'package:flutter/material.dart';
import 'package:imshy/model/user.dart';
import 'package:imshy/repo/repo.dart';
import 'package:imshy/repo/repo_utils.dart';
import 'package:imshy/utils.dart';

import '../main.dart';

class ProfileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileView();
  }
}

class _ProfileView extends State<ProfileView> {
  late UserRepository userRepo;
  late User me;

  late GlobalKey _keyStatusItem;
  late OverlayEntry _overlayEntry;
  late Size statusItemSize;
  late Offset statusItemPosition;

  bool editMode = false;
  bool isStateMenuOpen = false;
  @override
  void initState() {
    super.initState();

    userRepo = UserRepository();
    me = RepoUtils.getRandomUser(userRepo);

    _keyStatusItem = LabeledGlobalKey("status_item");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditController = TextEditingController();
    textEditController.text = getLorenIpsum();

    return Scaffold(
        body: ListView(children: [
          Column(children: [
            Container(
                constraints: BoxConstraints.expand(
                    width: double.infinity, height: 300.0),
                child: Stack(
                  children: [
                    profileBackground(),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: profileImage(),
                    ),
                  ],
                )),
            Text(
              me.name,
              style: TextStyle(fontSize: 20.0),
            ),
            Container(
                padding: EdgeInsets.only(left: 8, right: 32),
                alignment: AlignmentDirectional.topStart,
                child: Column(
                  children: [description()],
                ))
          ])
        ]),
        bottomNavigationBar: mProfileBottomAppBar(onHomePressed: () {
          Navigator.pushNamed(context, "/");
        }, onEditPressed: () {
          setState(() {
            editMode = !editMode;
          });
        }));
  }

  Widget profileBackground() => Container(
      alignment: Alignment.topCenter,
      height: 225,
      decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          border: Border.all(color: Colors.black87, width: 1),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                color: Colors.blueGrey,
                offset: Offset(10.0, 10.0))
          ]));

  Widget description() {
    var textEdit = TextEditingController();
    String text = me.description ?? "";
    textEdit.text = text;

    if (editMode) {
      return TextField(
        controller: textEdit,
      );
    } else {
      return Text(text);
    }
  }

  Widget profileImage() {
    Image img = me.profileImage ?? Image.asset("cute_dog.jpg");
    return ProfileImage(img.image);
  }

  Widget mProfileBottomAppBar(
          {Function? onHomePressed, Function? onEditPressed}) =>
      BottomAppBar(
          color: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // null aware
                    onEditPressed?.call();
                  }),
              IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    onHomePressed?.call();
                  }),
              statusItem(MyApp.state, (ItemStateType type) {
                openStatusItemMenu();
              }, key: _keyStatusItem)
            ],
          ));

  void findWidget() {
    RenderBox rBox =
        _keyStatusItem.currentContext?.findRenderObject() as RenderBox;
    statusItemSize = rBox.size;
    statusItemPosition = rBox.localToGlobal(Offset.zero);
  }

  void openStatusItemMenu() {
    findWidget();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)?.insert(_overlayEntry);
    isStateMenuOpen = !isStateMenuOpen;
  }

  void closeStatusItemMenu() {
    _overlayEntry.remove();
    isStateMenuOpen = !isStateMenuOpen;
  }

  OverlayEntry _overlayEntryBuilder() {
    print(statusItemPosition.dy);
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: statusItemSize.height,
          left: statusItemPosition.dx,
          width: statusItemSize.width,
          child: Material(
              color: Colors.transparent,
              child: allStatusItem((ItemStateType state) {
                stateItemClicked(state);
              })),
        );
      },
    );
  }

  void stateItemClicked(ItemStateType state) {}
}

class ProfileImage extends Container {
  ProfileImage(ImageProvider src)
      : super(
            height: 135,
            width: 135,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black87, style: BorderStyle.solid, width: 2),
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(image: src, fit: BoxFit.cover)));
}

Widget allStatusItem(Function(ItemStateType type) event) {
  return Column(
    children: [
      statusItem(ItemStateType.All, event),
      Divider(),
      statusItem(ItemStateType.Friendship, event),
      Divider(),
      statusItem(ItemStateType.Desactivated, event),
      Divider(),
    ],
  );
}

Widget statusItem(ItemStateType state, Function(ItemStateType) callback,
    {Key? key}) {
  Color color;
  String text;

  switch (state) {
    case ItemStateType.All:
      color = Colors.pink[400] ?? Colors.pink;
      text = "Tudo";
      break;
    case ItemStateType.Friendship:
      color = Colors.green;
      text = "Amizade";
      break;
    default:
      text = "Desativado";
      color = Colors.black87;
      break;
  }

  double width = 180.0;
  double height = 45.0;

  double textLeft = 35.0;
  double statusIconWidth = 10.0;
  double statusIconHeight = 10.0;
  double offset = 5.0 * 2;
  return Container(
      key: key,
      width: width,
      height: height,
      child: GestureDetector(
          onTap: () {
            callback(state);
          },
          child: Stack(alignment: Alignment.center, children: [
            // status icon
            Positioned(
              width: statusIconWidth,
              height: statusIconHeight,
              left: textLeft - statusIconWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
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
              left: textLeft + offset,
              child: Container(
                  decoration: BoxDecoration(),
                  child: Text(text,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold))),
            ),

            // text
          ])));
}
