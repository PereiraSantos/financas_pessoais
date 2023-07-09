import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../entities/finance/finance.dart';
import '../../../entities/outgoing/outgoing.dart';
import '../../../usercase/qr_code.dart';
import '../../../usercase/transitions_builder.dart';
import '../../../widgets/app_bar_widgets.dart';
import '../../../widgets/bottom_navigation_bar_widget.dart';
import '../../../widgets/list_outgoing_widgets.dart';
import '../../outgoing_add/page/outgoing_insert_page.dart';
import '../outigoing_list_controller/outgoing_list_controller.dart';

class OutgoingPage extends StatefulWidget {
  const OutgoingPage({super.key, required this.index});

  final int index;

  @override
  State<OutgoingPage> createState() => _OutgoingPageState();
}

class _OutgoingPageState extends State<OutgoingPage> {
  final OutgoingListController outgoingListController =
      OutgoingListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBarWidgets(label: 'Despesa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 05.0, left: 5.0, right: 5.0),
          child: Column(
            children: [
              ListOutgoingWidgets(
                controller: outgoingListController,
                idFinance: -1,
                search: outgoingListController.textController.text,
                onLoad: (value) => value,
                onClickDelete: (id) async {
                  await outgoingListController
                      .deleteOutgoing(id, context)
                      .whenComplete(() {
                    Navigator.pop(context);
                    setState(() {});
                  });
                },
                onClickUpdate: (Outgoing outgoing) async {
                  Outgoing? outgoingResult = await outgoingListController
                      .getOutgoingById(outgoing.id!);

                  // ignore: use_build_context_synchronously
                  var result = await Navigator.of(context).push(
                    TransitionsBuilder.createRoute(
                      OutgoingInsertPage(outgoing: outgoingResult),
                    ),
                  );

                  if (result) setState(() {});
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 60))
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
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

              if (result) setState(() {});
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
              Finance? finance =
                  await outgoingListController.getFinanceDateFinishIsNull();

              if (finance == null) {
                // ignore: use_build_context_synchronously
                outgoingListController.message(
                    context, "Não há finanças cadastrada!!!");
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

                  if (result) setState(() {});
                }
              }
            },
            child: const Icon(Icons.qr_code_2, size: 25, color: Colors.black54),
          ),
          /* FloatingActionButton(
            heroTag: "btn3",
            mini: true,
            backgroundColor: Colors.white,
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimpleBarcodeScannerPage(),
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

                  if (result) setState(() {});
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
      bottomNavigationBar: BottomNavigationBarWidget(index: widget.index),
    );
  }
}
