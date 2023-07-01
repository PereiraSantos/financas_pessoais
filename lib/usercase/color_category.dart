import 'package:flutter/material.dart';

class ColorCategory {
  static List<Color> cor = [
    Colors.white,
    Colors.white,
    Colors.orange[200]!,
    Colors.blue[200]!,
    Colors.pink[200]!,
    Colors.purple[200]!,
    Colors.teal[200]!,
  ];

  static getColor(int index) => cor[index];
}
