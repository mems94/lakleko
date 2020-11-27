import 'package:flutter/material.dart';

enum ActionsPopupButton { add, logout, delete, update }

final kBoxDecorationForFirstContainer = BoxDecoration(
  color: Color(0xFFEEEEF2),
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30.0),
    topLeft: Radius.circular(30.0),
  ),
);

final kInputDecorationForSearchTextField = InputDecoration(
  contentPadding: EdgeInsets.all(20.0),
  hintText: 'Search an access info',
  filled: true,
  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.search,
    color: Colors.black38,
    size: 25.0,
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  ),
);

final List<Widget> kTextInContainerAppBar = [
  Text(
    'Hello',
    style: TextStyle(letterSpacing: 2.0),
  ),
  Text(
    'It\'s a pleasure',
    style: TextStyle(letterSpacing: 2.0),
  ),
  Text(
    'to manage your access',
    style: TextStyle(letterSpacing: 2.0),
  ),
];

final kInputDecorationListviewAddUpdate = InputDecoration(
  hintText: 'Enter a site name : Github.com',
);
