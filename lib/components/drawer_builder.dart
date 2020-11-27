import 'package:flutter/material.dart';

class DrawerBuilder extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  DrawerBuilder({Key key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.format_align_center,
          size: 30.0,
          color: Colors.black54,
        ),
        onPressed: () {
          //Scaffold.of(context).openDrawer();
          scaffoldKey.currentState.openDrawer();
        });
  }
}
