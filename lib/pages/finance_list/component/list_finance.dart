import 'package:financas_pessoais/pages/finance_list/controller/finance_list_controller.dart';
import 'package:flutter/material.dart';

import '../../../entities/finance/finance.dart';
import '../../../usercase/format_date.dart';
import '../../../usercase/transitions_builder.dart';
import '../../finance_add/page/finance_insert_page.dart';

class ListFinance extends StatelessWidget {
  const ListFinance({
    super.key,
    required this.onClickSaveEdit,
    required this.onClickDelete,
    required this.financeListController,
  });

  final Function() onClickSaveEdit;
  final Function(int id) onClickDelete;
  final FinanceListController financeListController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 05.0, left: 5.0, right: 5.0),
        child: Column(
          children: [
            FutureBuilder(
              future: financeListController.getFinanceAll(),
              builder: (BuildContext context, AsyncSnapshot<List<Finance>> snapshot) {
                if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting) {
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
                                        "Deseja excluir? \n${Format.currentFormat(snapshot.data![index].value!)}",
                                        style: const TextStyle(color: Colors.black45, fontSize: 20),
                                      ),
                                      actions: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () => onClickDelete(snapshot.data![index].id!),
                                                style: ButtonStyle(
                                                  side: WidgetStateProperty.all(
                                                    const BorderSide(
                                                        width: 2, color: Color.fromARGB(80, 0, 0, 0)),
                                                  ),
                                                  foregroundColor: WidgetStateProperty.all(
                                                      const Color.fromARGB(80, 0, 0, 0)),
                                                  padding: WidgetStateProperty.all(
                                                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                                  ),
                                                  textStyle: WidgetStateProperty.all(
                                                    const TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                child: const Text("SIM"),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, false),
                                                style: ButtonStyle(
                                                  side: WidgetStateProperty.all(
                                                    const BorderSide(
                                                        width: 2, color: Color.fromARGB(80, 0, 0, 0)),
                                                  ),
                                                  foregroundColor: WidgetStateProperty.all(
                                                      const Color.fromARGB(80, 0, 0, 0)),
                                                  padding: WidgetStateProperty.all(
                                                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                                  ),
                                                  textStyle: WidgetStateProperty.all(
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
                              child: InkWell(
                                onTap: () async {
                                  Finance? finance =
                                      await financeListController.getFinanceById(snapshot.data![index].id!);

                                  // ignore: use_build_context_synchronously
                                  var result = await Navigator.of(context).push(
                                    TransitionsBuilder.createRoute(
                                      FinanceInsertPage(
                                          finance: finance, duplicate: snapshot.data!.isNotEmpty),
                                    ),
                                  );

                                  if (result) onClickSaveEdit();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2, left: 5, right: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: double.infinity,
                                          height: 25,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Receita: R\$ ${Format.currentFormat(snapshot.data![index].value!)}',
                                            style: const TextStyle(fontSize: 18, color: Colors.black54),
                                          )),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 25,
                                        child: Text(
                                          'De ${snapshot.data![index].dateStart} até ${snapshot.data![index].dateFinish ?? Format.formatDate(DateTime.now())}',
                                          style: const TextStyle(fontSize: 18, color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                    );
                  } else {
                    return Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.only(left: 12.0),
                      child: const Text(
                        "Não há finança!!!",
                        style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w300),
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
