import 'package:flutter/material.dart';
import 'package:financas_pessoais/entities/category/category.dart';
import '../../../widgets/app_bar_widgets.dart';
import '../../../widgets/text_button_widget.dart';
import '../../../widgets/text_form_field_widget.dart';
import '../component/color_category.dart';
import '../controller/category_add_controller.dart';

// ignore: must_be_immutable
class CategoryInsertPage extends StatelessWidget {
  CategoryInsertPage({super.key, this.category}) {
    initDescription();
  }

  Category? category;
  AddCategoryController addCategoryController = AddCategoryController();

  initDescription() async {
    if (category != null) {
      addCategoryController.description.text = category!.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBarWidgets(
            label: category != null ? "Editar Categoria" : "Nova Categoria"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: addCategoryController.categoryForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormFieldWidget(
                controller: addCategoryController.description,
                hintText: 'Descrição',
                keyboardType: TextInputType.text,
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: const Text(
                  'Cor',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54,
                  ),
                ),
              ),
              ColorCategoryCustom(
                  addCategoryController: addCategoryController,
                  category: category),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: const Color(0xffffffff),
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButtonWidget(
                label: 'CANCELA', onClick: () => Navigator.pop(context, false)),
            TextButtonWidget(
              label: category != null ? 'EDITAR' : 'SALVAR',
              onClick: () async {
                bool result = await addCategoryController.validateInput(
                    category?.id, context);
                if (result) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
