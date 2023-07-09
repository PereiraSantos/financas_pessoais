import 'package:flutter/material.dart';

import '../entities/category/category.dart';

class CategoryWidgets extends StatelessWidget {
  const CategoryWidgets({super.key, required this.category});

  final Category? category;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 5, left: 05, bottom: 05),
            child: Visibility(
              child: Text(
                "Categoria: ${category?.description ?? 'Padrão'}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(132, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(right: 10, top: 05),
            child: Text(
              category?.emoji ?? '',
              style: const TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
