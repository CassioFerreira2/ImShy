import 'package:flutter/material.dart';
import 'package:imshy/route/route_generator.dart';
import 'package:imshy/views/profile_view.dart';

void main() {
  runApp(MyApp());
}

enum ItemStateType { All, Friendship, Desactivated }

class MyApp extends StatelessWidget {
  static ItemStateType state = ItemStateType.All;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/profile',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
