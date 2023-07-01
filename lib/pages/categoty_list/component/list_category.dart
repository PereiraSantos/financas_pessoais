import 'package:flutter/material.dart';

import '../../../entities/category/category.dart';
import '../../../usercase/color_category.dart';
import '../../../usercase/transitions_builder.dart';
import '../../category_add/page/category_insert_page.dart';
import '../controller/category_list_controller.dart';

class ListCategoriy extends StatelessWidget {
  ListCategoriy({super.key, this.onFinish});
  final Function()? onFinish;
  final CategoryListController categoryListController =
      CategoryListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 05.0, left: 5.0, right: 5.0),
        child: Column(
          children: [
            FutureBuilder(
              future: categoryListController.getCategory(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Category>> snapshot) {
                if (!snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          color: ColorCategory.getColor(
                              snapshot.data![index].color ?? 0),
                          child: InkWell(
                            onTap: () async {
                              Category? category = await categoryListController
                                  .getCategoryById(snapshot.data![index].id!);

                              // ignore: use_build_context_synchronously
                              var result = await Navigator.of(context).push(
                                TransitionsBuilder.createRoute(
                                  CategoryInsertPage(category: category),
                                ),
                              );

                              if (result) onFinish;
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 2,
                                left: 5,
                                right: 5,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'Descrição: ${snapshot.data![index].description}',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.only(left: 12.0),
                      child: const Text(
                        "Não há categoria!!!",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.w300),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
