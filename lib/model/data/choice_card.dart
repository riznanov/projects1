import 'package:flutter/material.dart';

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

class Menu{
  const Menu({this.title, this.icon});

  final String title;
  final IconData icon;
}
const List<Choice> menu = const <Choice>[
  const Choice(title: 'Privacy Policy', icon: Icons.menu),
];

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Privacy Policy', icon: Icons.vpn_key),
];