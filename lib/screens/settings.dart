import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ABOUT APK'),
      ),
      body: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  'Apk name: LAKLEKO',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Version: 1.1',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Developed by: rba',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
