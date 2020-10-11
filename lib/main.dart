import 'package:construction_app/provider/data_provider.dart';
import 'package:construction_app/routes.dart';
import 'package:construction_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialization is necessary here.
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Data Provider to access the data and functions.
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        title: 'Construction App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: HomeScreen.routeName,
        routes: Routes.getRoutes(),
      ),
    );
  }
}
