import 'package:construction_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static final _routes = {
    HomeScreen.routeName: (context) => HomeScreen()
  };

  static Map<String, WidgetBuilder> getRoutes() {
    return _routes;
  }
}
