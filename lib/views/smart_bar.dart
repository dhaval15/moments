import 'package:flutter/material.dart';

class SmartBar extends AppBar {
  SmartBar(String title, {List<Widget> actions})
      : super(
          leading: Icon(Icons.menu),
          centerTitle: true,
          title: Text(title),
          actions: actions,
        );
}
