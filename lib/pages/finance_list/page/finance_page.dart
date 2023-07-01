import 'package:flutter/material.dart';

import '../../../entities/finance/finance.dart';
import '../../../usercase/format_date.dart';
import '../../../usercase/transitions_builder.dart';
import '../../../widgets/bottom_navigation_bar_widget.dart';
import '../../finance_add/page/finance_insert_page.dart';
import '../controller/finance_list_controller.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key, this.index = 0});

  final int? index;

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  final FinaceListController finaceListController = FinaceListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: const Text(
          'Finança',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w300,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 05.0, left: 5.0, right: 5.0),
          child: FutureBuilder(
            future: finaceListController.getFinanceAll(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Finance>> snapshot) {
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
                        child: InkWell(
                          onTap: () async {
                            Finance? finance = await finaceListController
                                .getFinanceById(snapshot.data![index].id!);

                            // ignore: use_build_context_synchronously
                            var result = await Navigator.of(context).push(
                              TransitionsBuilder.createRoute(
                                FinanceInsertPage(finance: finance),
                              ),
                            );

                            if (result) setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 2, left: 5, right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: double.infinity,
                                    height: 25,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Receita: R\$ ${Format.currentFormat(snapshot.data![index].value)}',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                    )),
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 25,
                                  child: Text(
                                    'De ${snapshot.data![index].dateStart} até ${snapshot.data![index].dateFinish ?? Format.formatDate(DateTime.now())}',
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
                      "Não há finança!!!",
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
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          var result = await Navigator.of(context).push(
            TransitionsBuilder.createRoute(
              FinanceInsertPage(),
            ),
          );

          if (result) setState(() {});
        },
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
          child: const Padding(
            padding:
                EdgeInsets.only(left: 10.0, right: 10.0, top: 3, bottom: 3),
            child: Text('+ Adicionar nova finança',
                style: TextStyle(fontSize: 14)),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(index: widget.index!),
    );
  }
}