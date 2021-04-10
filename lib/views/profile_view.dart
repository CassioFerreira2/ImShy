import 'package:flutter/material.dart';
import 'package:imshy/general_components/bottom_bar/top_bar.dart';
import 'package:imshy/general_components/bottom_bar/state_item.dart';
import 'package:imshy/general_components/bottom_bar/state_menu.dart';
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
      body: Stack(children: [
        ListView(children: [
          Column(children: [
            Container(
                constraints: BoxConstraints.expand(
                    width: double.infinity, height: 300.0),
                child: Stack(
                  children: [
                    //profileBackground(),
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
                )),
          ])
        ]),
        ImshyTopBar()
      ]),
    );
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [StateMenu(stateChanged: (_) {})],
          ));

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
