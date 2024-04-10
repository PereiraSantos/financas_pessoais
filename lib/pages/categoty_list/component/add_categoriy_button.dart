import 'package:flutter/material.dart';

import '../../../usercase/transitions_builder.dart';
import '../../category_add/page/category_insert_page.dart';

class AddCategoriyButton extends StatelessWidget {
  const AddCategoriyButton({super.key, required this.onFinish});

  final Function() onFinish;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var result = await Navigator.of(context).push(
          TransitionsBuilder.createRoute(
            CategoryInsertPage(),
          ),
        );

        if (result) onFinish();
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        child: const Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 3, bottom: 3),
          child: Text(
            'Nova categoria',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
