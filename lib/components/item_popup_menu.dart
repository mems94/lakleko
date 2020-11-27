import 'package:flutter/material.dart';
import 'package:lakleko/constants/constants.dart';

PopupMenuItem<ActionsPopupButton> itemPopupMenu(
  ActionsPopupButton actions,
  IconData icon,
  String text,
) {
  return PopupMenuItem(
    value: actions,
    child: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.grey.shade600,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(text)
      ],
    ),
  );
}
