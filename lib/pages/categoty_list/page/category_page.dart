import 'package:financas_pessoais/pages/categoty_list/controller/category_list_controller.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_bar_widgets.dart';
import '../../../widgets/bottom_navigation_bar_widget.dart';

import '../component/add_categoriy_button.dart';
import '../component/list_category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.index});

  final int index;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryListController categoryListController = CategoryListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBarWidgets(label: 'Categoria'),
      ),
      body: ListCategoriy(
          onClickSaveEdit: () => setState(() {}),
          onClickDelete: (int id) {
            categoryListController.deteleCategoryById(context, id);
            Navigator.pop(context);
            setState(() {});
          },
          categoryListController: categoryListController),
      floatingActionButton: AddCategoriyButton(onFinish: () => setState(() {})),
      bottomNavigationBar: BottomNavigationBarWidget(index: widget.index),
    );
  }
}
