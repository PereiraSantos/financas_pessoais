import 'package:flutter/material.dart';

import '../../../database/database_category_repository.dart';
import '../../../database/database_floor/database_category.dart';
import '../../../entities/category/category.dart';

class AddCategoryController {
  final categoryForm = GlobalKey<FormState>();
  TextEditingController description = TextEditingController();
  int color = 0;

  DataBaseCategoryRepository dataBaseCategoryRepository =
      DataBaseCategoryRepository(DatabaseCategoryFloor());

  void setColor(int index) => color = index;

  Future<bool> validateInput(int? id, BuildContext context) async {
    if (categoryForm.currentState!.validate()) {
      id != null
          ? await dataBaseCategoryRepository.updateCategory(
              description.text, color, id)
          : await dataBaseCategoryRepository.insertCategory(
              Category(description: description.text, color: color),
            );

      return await Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
