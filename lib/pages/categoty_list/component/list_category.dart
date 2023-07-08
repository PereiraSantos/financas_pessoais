import 'package:flutter/material.dart';

import '../../../entities/category/category.dart';
import '../../../usercase/color_category.dart';
import '../../../usercase/transitions_builder.dart';
import '../../category_add/page/category_insert_page.dart';
import '../controller/category_list_controller.dart';

class ListCategoriy extends StatelessWidget {
  const ListCategoriy({
    super.key,
    required this.onClickSaveEdit,
    required this.onClickDelete,
    required this.categoryListController,
  });
  final Function() onClickSaveEdit;
  final Function(int id) onClickDelete;
  final CategoryListController categoryListController;

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
                        return Dismissible(
                          key: Key('${snapshot.data![index].id}'),
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(
                                      "Deseja excluir? \n${snapshot.data![index].description}",
                                      style: const TextStyle(
                                          color: Colors.black45, fontSize: 20),
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              onPressed: () => onClickDelete(
                                                  snapshot.data![index].id!),
                                              style: ButtonStyle(
                                                side: MaterialStateProperty.all(
                                                  const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          80, 0, 0, 0)),
                                                ),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color.fromARGB(
                                                            80, 0, 0, 0)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 40),
                                                ),
                                                textStyle:
                                                    MaterialStateProperty.all(
                                                  const TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              child: const Text("SIM"),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              style: ButtonStyle(
                                                side: MaterialStateProperty.all(
                                                  const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          80, 0, 0, 0)),
                                                ),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color.fromARGB(
                                                            80, 0, 0, 0)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 40),
                                                ),
                                                textStyle:
                                                    MaterialStateProperty.all(
                                                  const TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              child: const Text("NÃO"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            return null;
                          },
                          child: Card(
                            elevation: 4,
                            color: ColorCategory.getColor(
                                snapshot.data![index].color ?? 0),
                            child: InkWell(
                              onTap: () async {
                                Category? category =
                                    await categoryListController
                                        .getCategoryById(
                                            snapshot.data![index].id!);

                                // ignore: use_build_context_synchronously
                                var result = await Navigator.of(context).push(
                                  TransitionsBuilder.createRoute(
                                    CategoryInsertPage(category: category),
                                  ),
                                );

                                if (result) onClickSaveEdit();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 2,
                                  left: 5,
                                  right: 5,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          'Descrição: ${snapshot.data![index].description}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          ' ${snapshot.data![index].emoji ?? ''}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
            const Padding(padding: EdgeInsets.only(bottom: 50))
          ],
        ),
      ),
    );
  }
}
