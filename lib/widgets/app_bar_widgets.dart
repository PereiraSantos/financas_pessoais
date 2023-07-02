import 'package:flutter/material.dart';

class AppBarWidgets extends StatelessWidget {
  const AppBarWidgets({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xffffffff),
      elevation: 0,
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w300,
          color: Colors.black87,
        ),
      ),
    );
  }
}
