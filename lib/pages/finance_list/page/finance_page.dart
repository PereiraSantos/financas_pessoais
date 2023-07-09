import 'package:flutter/material.dart';

import '../../../usercase/transitions_builder.dart';
import '../../../widgets/app_bar_widgets.dart';
import '../../../widgets/bottom_navigation_bar_widget.dart';
import '../../finance_add/page/finance_insert_page.dart';
import '../component/list_finance.dart';
import '../controller/finance_list_controller.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key, this.index = 0});

  final int? index;

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  final FinanceListController financeListController = FinanceListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBarWidgets(label: 'Finança'),
      ),
      body: ListFinance(
          financeListController: financeListController,
          onClickDelete: (int id) async {
            await financeListController
                .deteleFinanceById(context, id)
                .whenComplete(() {
              Navigator.pop(context);
              setState(() {});
            });
          },
          onClickSaveEdit: () => setState(() {})),
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
