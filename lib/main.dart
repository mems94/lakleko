import 'package:flutter/material.dart';
import 'package:lakleko/models/lisa_login_model.dart';
import 'package:lakleko/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => LisaLoginModel(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF426E6D),
        accentColor: Color(0xFF426E6D),
      ),
      home: MySplashScreen(),
    );
  }
}

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: LoginScreen(),
      title: Text(
        'Lakleko',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 60,
        ),
      ),
      backgroundColor: Color(0xFF426E6D),
      loaderColor: Colors.white,
    );
  }
}
