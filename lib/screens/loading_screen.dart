import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lakleko/screens/create_user.dart';
import 'package:lakleko/screens/login_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingBounce();
  }

  void loadingBounce() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    loadingBounce();
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Color(0xFF426E6D),
          size: 250.0,
        ),
      ),
    );
  }
}
