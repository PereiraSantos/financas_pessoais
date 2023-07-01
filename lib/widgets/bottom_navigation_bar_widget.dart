import 'package:flutter/material.dart';
import 'package:financas_pessoais/pages/home/page/home_page.dart';

import '../pages/categoty_list/page/category_page.dart';
import '../pages/finance_list/page/finance_page.dart';
import '../pages/outgoing_list/page/outgoing_page.dart';
import '../usercase/transitions_builder.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({
    super.key,
    this.index = 0,
  });

  final int index;

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 14,
      unselectedFontSize: 12,
      backgroundColor: Colors.white,
      elevation: 8,
      iconSize: 20,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.paid,
          ),
          label: ' Finança',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.sell,
          ),
          label: 'Categoria',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.currency_exchange,
          ),
          label: ' Despesa',
        ),
      ],
      currentIndex: widget.index,
      selectedItemColor: Colors.black,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.of(context).push(
              TransitionsBuilder.createRoute(
                HomePage(index: index),
              ),
            );
            break;
          case 1:
            Navigator.of(context).push(
              TransitionsBuilder.createRoute(
                FinancePage(index: index),
              ),
            );
            break;
          case 2:
            Navigator.of(context).push(
              TransitionsBuilder.createRoute(
                CategoryPage(index: index),
              ),
            );

            break;
          case 3:
            Navigator.of(context).push(
              TransitionsBuilder.createRoute(
                OutgoingPage(index: index),
              ),
            );
            break;
        }
        setState(() {});
      },
    );
  }
}
