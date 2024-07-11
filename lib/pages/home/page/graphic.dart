import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

import '../../../usercase/showing_sections.dart';

class GraphicPage extends StatefulWidget {
  const GraphicPage({
    super.key,
    required this.rendaRelatorio,
    required this.poupar,
    required this.sobra,
    required this.total,
  });

  final double rendaRelatorio;
  final double poupar;
  final double sobra;
  final double total;

  @override
  State<GraphicPage> createState() => _GraphicPageState();
}

class _GraphicPageState extends State<GraphicPage> {
  bool isExpandedPainel = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          isExpandedPainel = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 10.0),
              child: Text(
                "Relatório finança",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            );
          },
          isExpanded: isExpandedPainel,
          canTapOnHeader: true,
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 22,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.03,
                                height: 10,
                                color: const Color.fromARGB(213, 76, 175, 79),
                                padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 22,
                                padding: const EdgeInsets.fromLTRB(5, 0, 2, 2),
                                child: const Text(
                                  "Receita",
                                  style: TextStyle(color: Colors.black54, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        /* SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 22,
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                    height: 10,
                                    color: const Color.fromARGB(
                                        213, 76, 175, 79),
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 2, 2, 2),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: 22,
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 2, 2),
                                    child: const Text(
                                      "Guardado",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),*/
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 22,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.03,
                                height: 10,
                                color: const Color.fromARGB(216, 33, 149, 243),
                                padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 22,
                                padding: const EdgeInsets.fromLTRB(5, 0, 2, 2),
                                child: const Text(
                                  "Saldo atual",
                                  style: TextStyle(color: Colors.black54, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text("Renda",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(183, 0, 0, 0))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5.0),
                              child: Text(
                                'R\$:${Format.currentFormat(widget.rendaRelatorio.toStringAsFixed(2))}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(183, 0, 0, 0)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
              AspectRatio(
                aspectRatio: 1.5,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: Grafico(poupar: widget.poupar, sobra: widget.sobra, total: widget.total)
                        .showingSections(),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
