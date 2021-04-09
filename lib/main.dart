import 'package:flutter/material.dart';
import 'package:imshy/route/route_generator.dart';
import 'package:imshy/views/profile_view.dart';

import 'general_components/bottom_bar/state_item.dart';

void main() {
  runApp(MyApp());
}

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
