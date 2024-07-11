import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'format_date.dart';

class Grafico {
  int touchedIndex = -1;
  double total;
  double sobra;
  double poupar;

  Grafico({required this.total, required this.sobra, required this.poupar});

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color.fromARGB(213, 76, 175, 79),
            value: total,
            title: Format.currentFormat(total),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color.fromARGB(213, 76, 175, 79),
            value: poupar,
            title: Format.currentFormat(poupar),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color.fromARGB(216, 33, 149, 243),
            value: sobra,
            title: Format.currentFormat(sobra),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        default:
          throw Error();
      }
    });
  }
}
