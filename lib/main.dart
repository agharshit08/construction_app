import 'package:construction_app/provider/data_provider.dart';
import 'package:construction_app/routes.dart';
import 'package:construction_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          initialRoute: HomeScreen.routeName,
          routes: Routes.getRoutes()),
    );
  }
}
