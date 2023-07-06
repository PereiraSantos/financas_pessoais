import 'package:flutter/material.dart';
import 'package:financas_pessoais/entities/category/category.dart';
import 'package:financas_pessoais/entities/outgoing/outgoing.dart';

import '../../../usercase/color_category.dart';
import '../../../usercase/format_date.dart';
import '../../outgoing_list/outigoing_list_controller/outgoing_list_controller.dart';

class ListOutgoing extends StatelessWidget {
  const ListOutgoing({
    super.key,
    required this.controller,
    this.search,
    required this.onClickDelete,
    required this.onClickUpdate,
    required this.onLoad,
    this.idFinance,
  });

  final OutgoingListController controller;
  final String? search;
  final Function(int) onClickDelete;
  final Function(Outgoing) onClickUpdate;
  final Function(int) onLoad;
  final int? idFinance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: idFinance == -1
          ? controller.getOutgoingAll()
          : controller.getOutgoingLast(value: search, idFinance: idFinance),
      builder: (BuildContext context, AsyncSnapshot<List<Outgoing>> snapshot) {
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
                              "Deseja excluir? \n${Format.currentFormat(snapshot.data![index].description!)}",
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
                                              color:
                                                  Color.fromARGB(80, 0, 0, 0)),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    80, 0, 0, 0)),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 40),
                                        ),
                                        textStyle: MaterialStateProperty.all(
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
                                              color:
                                                  Color.fromARGB(80, 0, 0, 0)),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    80, 0, 0, 0)),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 40),
                                        ),
                                        textStyle: MaterialStateProperty.all(
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: GestureDetector(
                      onTap: () => onClickUpdate(snapshot.data![index]),
                      child: FutureBuilder(
                          future: controller.categoryRepository
                              .findCategoryById(
                                  snapshot.data![index].idCategory ?? -1),
                          builder: (BuildContext context,
                              AsyncSnapshot<Category?> snapshotCategory) {
                            if (!snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return const SizedBox(
                                width: 10,
                                height: 10,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return Card(
                                elevation: 8,
                                color: ColorCategory.getColor(
                                    snapshotCategory.data?.color ?? 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: double.maxFinite,
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 05),
                                            child: Text(
                                              'Descrição: ${snapshot.data![index].description}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      132, 0, 0, 0)),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            width: double.maxFinite,
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 05, bottom: 08),
                                            child: Visibility(
                                              visible: snapshot.data?[index]
                                                          .idCategory !=
                                                      0
                                                  ? true
                                                  : false,
                                              child: Text(
                                                "Categoria: ${snapshotCategory.data?.description ?? 'Padrão'}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      132, 0, 0, 0),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topRight,
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 05, right: 10),
                                            height: 20,
                                            child: Text(
                                                'R\$ ${Format.currentFormat(snapshot.data![index].value)}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        132, 0, 0, 0)),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: double.maxFinite,
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                left: 05,
                                                right: 10,
                                                bottom: 08),
                                            child: Text(
                                              Format.formatDateWek(
                                                  snapshot.data![index].date!),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      132, 0, 0, 0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }),
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
                "Não há despesas!!!",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
            );
          }
        }
      },
    );
  }
}
