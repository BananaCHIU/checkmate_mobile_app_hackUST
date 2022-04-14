import 'package:checkmate_mobile_app/Core/NavBar.dart';
import 'package:flutter/material.dart';

import 'Authentication/Login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // backgroundColor: Colors.white,
        fontFamily: 'Helvetica',
      ),
      title: 'CheckMate_Mobile',
      // Routes
      routes: <String, WidgetBuilder>{
        '/': (_) => new Login(),
        '/home': (_) => new NavBar(), // Home Page
      },
    );
  }
}