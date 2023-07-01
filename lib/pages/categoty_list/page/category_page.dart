import 'package:flutter/material.dart';

import '../../../widgets/bottom_navigation_bar_widget.dart';

import '../component/add_categoriy_button.dart';
import '../component/app_bar_categoriy.dart';
import '../component/list_category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.index});

  final int index;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBarCategoriy(),
      ),
      body: ListCategoriy(onFinish: () => setState(() {})),
      floatingActionButton: AddCategoriyButton(onFinish: () => setState(() {})),
      bottomNavigationBar: BottomNavigationBarWidget(index: widget.index),
    );
  }
}
