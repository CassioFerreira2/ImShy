import 'package:flutter/cupertino.dart';

class User {
  AssetImage profileImage;
  String name;
  String description;
  User(String name, AssetImage profileImage, String description) {
    this.name = name;
    this.description = description;
    this.profileImage = profileImage;
  }
}
