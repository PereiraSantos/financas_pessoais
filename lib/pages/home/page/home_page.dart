import 'package:flutter/material.dart';
import 'package:financas_pessoais/entities/finance/finance.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../entities/outgoing/outgoing.dart';
import '../../../usercase/format_date.dart';
import '../../../usercase/qr_code.dart';
import '../../../usercase/transitions_builder.dart';
import '../../../widgets/bottom_navigation_bar_widget.dart';
import '../../finance_add/page/finance_insert_page.dart';
import '../../finance_list/controller/finance_list_controller.dart';
import '../../outgoing_add/controller/outgoing_add_controller.dart';
import '../../outgoing_list/outigoing_list_controller/outgoing_list_controller.dart';
import '../../outgoing_add/page/outgoing_insert_page.dart';
import '../../../widgets/list_outgoing_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.index = 0});
  final int? index;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var showFilter = false;
  int sizeList = 0;
  Finance? finance;
  OutgoingListController outgoingListController = OutgoingListController();
  ValueNotifier<double> totalOutgoing = ValueNotifier<double>(0.0);
  OutgoingAddController outgoingAddController = OutgoingAddController();

  void reloadPage() => setState(() {});

  Future<Finance?> findFinanceHomePage() async {
    finance = await FinanceListController().getFinance(null);

    if (finance != null) {
      List<Outgoing> list = await outgoingListController.findAllOutgoingByIdFinance(finance?.id ?? -1);

      totalOutgoing.value = 0;

      for (Outgoing element in list) {
        totalOutgoing.value += double.parse(element.value.toString());
      }
    }

    return Future.value(finance);
  }

  Widget text(String value, double font, {double? top, Color? color}) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 10, top: top ?? 5.0),
      child: Text(value, style: TextStyle(fontSize: font, fontWeight: FontWeight.w300, color: color)),
    );
  }

  double calulate(double value, double element) {
    double result = element - value;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: FutureBuilder(
          future: findFinanceHomePage(),
          builder: (BuildContext context, AsyncSnapshot<Finance?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data != null) {
                return Text('Finança ${Format.formatDateMonth(snapshot.data?.dateStart ?? '')} ',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87,
                    ));
              }
              return const Text(
                'Não há Finança',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  color: Colors.black87,
                ),
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 05.0, left: 5.0, right: 5.0),
          child: Column(
            children: [
              FutureBuilder(
                future: findFinanceHomePage(),
                builder: (BuildContext context, AsyncSnapshot<Finance?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data != null) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                text('Receita', 15, top: 05),
                                text('Saldo atual', 15, top: 2),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 16,
                            child: Column(
                              children: [
                                text('R\$ ${Format.currentFormat(snapshot.data?.value ?? 0)}', 13.5, top: 05),
                                ValueListenableBuilder(
                                  valueListenable: totalOutgoing,
                                  builder: (context, value, child) {
                                    return text(
                                        'R\$ ${Format.currentFormat(calulate(value, snapshot.data?.value ?? 0))}',
                                        13.5,
                                        top: 2,
                                        color: calulate(value, snapshot.data?.value ?? 0) < 0
                                            ? Colors.red
                                            : null);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  }
                },
              ),
              Container(
                width: double.maxFinite,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 05, top: 10),
                child: GestureDetector(
                  onTap: () async {
                    Finance? finance = await findFinanceHomePage();
                    // ignore: use_build_context_synchronously
                    var result = await Navigator.of(context).push(
                      TransitionsBuilder.createRoute(
                        FinanceInsertPage(duplicate: finance != null ? true : false),
                      ),
                    );

                    if (result) reloadPage();
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 3, bottom: 3),
                      child: Text('Nova finança', style: TextStyle(fontSize: 12, color: Colors.black38)),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Divider(
                  color: Color.fromARGB(99, 158, 158, 158),
                  height: 1,
                  endIndent: 10,
                  indent: 10,
                ),
              ),
              text('Últimas despesas', 18, top: 20),
              FutureBuilder(
                future: FinanceListController().getFinance(null),
                builder: (BuildContext context, AsyncSnapshot<Finance?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data != null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListOutgoingWidgets(
                            controller: outgoingListController,
                            idFinance: snapshot.data!.id,
                            search: outgoingAddController.textController.text,
                            onLoad: (value) => sizeList = value,
                            onClickDelete: (id) async {
                              await outgoingAddController.deleteOutgoing(id, context).whenComplete(() {
                                Navigator.pop(context);
                                reloadPage();
                              });
                            },
                            onClickUpdate: (Outgoing outgoing) async {
                              // ignore: use_build_context_synchronously
                              var result = await Navigator.of(context).push(
                                TransitionsBuilder.createRoute(
                                  OutgoingInsertPage(outgoing: outgoing),
                                ),
                              );

                              if (result) reloadPage();
                            },
                          ),
                        ],
                      );
                    } else {
                      return SizedBox(
                        width: double.maxFinite,
                        child: text('Não há despesas', 12),
                      );
                    }
                  }
                },
              ),
              text('Nova despesa', 18),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 05, top: 10, bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      heroTag: "btn1",
                      mini: true,
                      backgroundColor: Colors.white,
                      onPressed: () async {
                        var result = await Navigator.of(context).push(
                          TransitionsBuilder.createRoute(
                            OutgoingInsertPage(),
                          ),
                        );

                        if (result) reloadPage();
                      },
                      child: const Icon(
                        Icons.keyboard,
                        size: 25,
                        color: Colors.black54,
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: "btn2",
                      mini: true,
                      backgroundColor: Colors.white,
                      onPressed: () async {
                        Finance? finance = await outgoingListController.getFinanceDateFinishIsNull();

                        if (finance == null) {
                          // ignore: use_build_context_synchronously
                          outgoingAddController.message(context, "Não há finanças cadastrada!!!");
                          return;
                        }
                        // ignore: use_build_context_synchronously
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SimpleBarcodeScannerPage(),
                          ),
                        );

                        if (result != -1) {
                          List<Outgoing> listOutgoing = await QrCode.readQrCode(result);
                          if (listOutgoing.isNotEmpty) {
                            var result =
                                // ignore: use_build_context_synchronously
                                await Navigator.of(context).push(
                              TransitionsBuilder.createRoute(
                                OutgoingInsertPage(listOutgoing: listOutgoing),
                              ),
                            );

                            if (result) reloadPage();
                          }
                        }
                      },
                      child: const Icon(Icons.qr_code_2, size: 25, color: Colors.black54),
                    ),
                    /*FloatingActionButton(
                      heroTag: "btn3",
                      mini: true,
                      backgroundColor: Colors.white,
                      onPressed: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SimpleBarcodeScannerPage(),
                          ),
                        );

                        if (result != -1) {
                          List<Outgoing> listOutgoing =
                              await QrCode.readQrCode(result, 1);
                          if (listOutgoing.isNotEmpty) {
                            var result =
                                // ignore: use_build_context_synchronously
                                await Navigator.of(context).push(
                              TransitionsBuilder.createRoute(
                                OutgoingInsertPage(listOutgoing: listOutgoing),
                              ),
                            );

                            if (result) reloadPage();
                          }
                        }
                      },
                      child: Transform.rotate(
                        angle: 180 * math.pi / 360,
                        child: const Icon(
                          Icons.horizontal_split,
                          size: 25,
                          color: Colors.black54,
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
              /* Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: ValueListenableBuilder(
                    valueListenable: totalOutgoing,
                    builder: (context, value, child) {
                      return GraphicPage(
                        poupar: 0,
                        sobra:
                            calulate(totalOutgoing.value, finance?.value ?? 0),
                        rendaRelatorio: finance?.value ?? 0,
                        total: finance?.value ?? 0,
                      );
                    }),
              ),*/
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
