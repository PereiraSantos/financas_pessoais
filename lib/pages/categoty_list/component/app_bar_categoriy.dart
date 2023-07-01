import 'package:flutter/material.dart';

class AppBarCategoriy extends StatelessWidget {
  const AppBarCategoriy({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xffffffff),
      elevation: 0,
      title: const Text(
        'Categoria',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w300,
          color: Colors.black87,
        ),
      ),
    );
  }
}
