import 'package:flutter/material.dart';

class ColorCategory {
  static List<Color> cor = [
    Colors.white,
    Colors.white,
    Colors.grey[200]!,
    Colors.orange[200]!,
    Colors.orangeAccent[200]!,
    Colors.yellow[200]!,
    Colors.yellowAccent[200]!,
    Colors.amber[300]!,
    Colors.blue[200]!,
    Colors.blueAccent[200]!,
    Colors.red[200]!,
    Colors.redAccent[200]!,
    Colors.pink[200]!,
    Colors.pinkAccent[200]!,
    Colors.purple[200]!,
    Colors.purpleAccent[200]!,
    Colors.teal[200]!,
    Colors.green[200]!,
    Colors.greenAccent[200]!,
  ];

  static getColor(int index) => cor[index];
}
