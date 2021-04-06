import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:imshy/model/user.dart';
import 'package:imshy/views/profile_view.dart';

class FakeClient {
  static List<User> generatefakeUsers() {
    List<User> users = [];

    users.add(User(
        name: "Milczareck",
        description:
            """Hello I'm a 16 boy. I used to watch animes in my free time,
                          but most time I program! """,
        profileImage: Image.asset("mina_do_anime_de_cartas.jpg")));

    users.add(User(
        name: "cute dog",
        description: """ 
          hello im a cute dog
        """,
        profileImage: Image.asset("cute_dog.jpg")));

    return users;
  }
}
