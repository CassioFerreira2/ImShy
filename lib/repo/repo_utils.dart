import 'dart:math';

import 'package:imshy/model/user.dart';
import 'package:imshy/repo/repo.dart';

class RepoUtils {
  static User getRandomUser(UserRepository repo) {
    var users = repo.getUsers();
    return users[Random().nextInt(users.length)];
  }
}
