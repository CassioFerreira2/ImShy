
import 'package:imshy/data/fake_data.dart';
import 'package:imshy/model/user.dart';

class UserRepository {
  final List<User> _users = FakeClient.generatefakeUsers();

  List<User> getUsers() => _users;

  User? getUserByName(String name) {
    for (var user in _users) {
      if (user.name == name) {
        return user;
      }
    }
    return null;
  }
}
