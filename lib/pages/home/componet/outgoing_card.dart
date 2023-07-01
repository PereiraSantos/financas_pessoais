import 'package:flutter/material.dart';

import '../../../usercase/format_date.dart';

class FinanceCard extends StatelessWidget {
  const FinanceCard(
      {super.key,
      required this.onClick,
      required this.onClickHistory,
      this.renda,
      this.poupar,
      this.sobra});

  final Function() onClick;
  final Function() onClickHistory;
  final double? renda;
  final double? poupar;
  final double? sobra;

  @override
  Widget build(BuildContext context) {
    if (renda == null && poupar == null && sobra == null) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Row(
          children: [
            const Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Não há finanças",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: onClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(5),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 25,
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text(
                          "Receita",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(183, 0, 0, 0)),
                        ),
                      ),
                      //color: Colors.amber,
                    ),
                    Container(
                      width: double.infinity,
                      height: 25,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'R\$:${Format.currentFormat(renda ?? 0)}',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(183, 0, 0, 0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /*  Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text("Guardado",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(183, 0, 0, 0))),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 25,
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'R\$:${Format.currentFormat(poupar ?? 0)}',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(183, 0, 0, 0)),
                          )),
                    ),
                  ],
                ),
              ),*/
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      height: 25,
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text("Saldo atual",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(183, 0, 0, 0))),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 25,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'R\$:${Format.currentFormat(sobra ?? 0)}',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(183, 0, 0, 0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /* Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: ElevatedButton(
                        onPressed: onClickHistory,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(0),
                        ),
                        child: const Icon(
                          Icons.history,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: ElevatedButton(
                          onPressed: onClick,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(0),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )*/
            ],
          ),
        ),
      );
    }
  }
}
