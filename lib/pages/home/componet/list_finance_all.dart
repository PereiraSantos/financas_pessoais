import 'package:flutter/material.dart';
import '../../../entities/finance/finance.dart';
import '../../../usercase/format_date.dart';
import '../../finance_list/controller/finance_list_controller.dart';

void listFinanceAll(BuildContext context, FinanceListController controller,
    Function(Finance) onClick) {
  showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 20),
                  child: Text(
                    "Financas",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, top: 10.0, right: 15.0, bottom: 25.0),
                child: FutureBuilder(
                  future: controller.getFinanceAll(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Finance>> snapshot) {
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
                                onTap: () {
                                  onClick(snapshot.data![index]);
                                  Navigator.of(context).pop();
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
                                            'R\$:${Format.currentFormat(snapshot.data![index].value!)}',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          )),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 25,
                                        child: Text(
                                          '${snapshot.data![index].dateStart} até ${snapshot.data![index].dateFinish ?? Format.formatDate(DateTime.now())}',
                                          style: const TextStyle(fontSize: 18),
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
                          padding: const EdgeInsets.only(left: 18.0),
                          child: const Text(
                            "Não há despesas!!!",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w300),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
