import 'package:flutter/material.dart';
import 'package:imshy/model/user.dart';
import 'package:imshy/repo/repo.dart';
import 'package:imshy/repo/repo_utils.dart';
import 'package:imshy/utils.dart';

class ProfileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileView();
  }
}

class _ProfileView extends State<ProfileView> {
  late UserRepository userRepo;
  late User me;

  bool editMode = false;
  @override
  void initState() {
    super.initState();

    userRepo = UserRepository();
    me = RepoUtils.getRandomUser(userRepo);
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
                      child: ProfileImage('assets/cute.jpg'),
                    )
                  ],
                )),
            Text(
              "ImSoCuute",
              style: TextStyle(fontSize: 20.0),
            ),
            Container(
                padding: EdgeInsets.only(left: 8, right: 32),
                alignment: AlignmentDirectional.topStart,
                child: Column(
                  children: [
                    editMode
                        ? TextField(
                            controller: textEditController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            autofocus: true,
                          )
                        : Text(getLorenIpsum())
                  ],
                ))
          ])
        ]),
        bottomNavigationBar: mProfileBottomAppBar(() {}, () {
          print(editMode);

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
}

class ProfileImage extends Container {
  ProfileImage(String asset)
      : super(
            height: 135,
            width: 135,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black87, style: BorderStyle.solid, width: 2),
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(image: AssetImage(asset))));
}

Widget mProfileBottomAppBar(Function onHomePressed, Function onEditPressed) =>
    BottomAppBar(
        color: Colors.grey[400],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  onEditPressed();
                }),
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  onHomePressed();
                })
          ],
        ));
