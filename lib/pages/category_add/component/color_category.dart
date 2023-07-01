import 'package:flutter/material.dart';
import 'package:financas_pessoais/entities/category/category.dart';

import '../../../usercase/color_category.dart';
import '../controller/category_add_controller.dart';

// ignore: must_be_immutable
class ColorCategoryCustom extends StatefulWidget {
  ColorCategoryCustom(
      {super.key, required this.addCategoryController, this.category});

  AddCategoryController addCategoryController;
  Category? category;

  @override
  State<ColorCategoryCustom> createState() => _ColorCategoryCustomState();
}

class _ColorCategoryCustomState extends State<ColorCategoryCustom> {
  int select = 1;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      initSelect();
    }
  }

  initSelect() {
    select = widget.category!.color!;
  }

  Widget color(int index) {
    return GestureDetector(
      onTap: () {
        widget.addCategoryController.setColor(index);
        select = index;
        setState(() {});
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorCategory.getColor(index),
              border: Border.all(color: Colors.grey),
            ),
            padding: const EdgeInsets.all(8),
          ),
          Visibility(
            visible: index == select ? true : false,
            child: const Center(
              child: Icon(
                Icons.check,
                color: Colors.black87,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 500,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 6,
        children: <Widget>[
          color(1),
          color(2),
          color(3),
          color(4),
          color(5),
          color(6),
        ],
      ),
    );
  }
}
