import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:financas_pessoais/entities/category/category.dart';
import 'package:financas_pessoais/entities/finance/finance.dart';
import 'package:financas_pessoais/entities/outgoing/outgoing.dart';
import 'package:financas_pessoais/pages/categoty_list/page/category_page.dart';
import 'package:financas_pessoais/pages/finance_list/controller/finance_list_controller.dart';

import '../../../usercase/currency_input_formatter.dart';
import '../../../usercase/date_mask.dart';

import '../../../usercase/transitions_builder.dart';
import '../../../widgets/text_button_widget.dart';
import '../../../widgets/text_form_field_widget.dart';
import '../../categoty_list/controller/category_list_controller.dart';

import '../../outgoing_list/outigoing_list_controller/outgoing_list_controller.dart';
import '../component/dropdown_button_category.dart';
import '../component/dropdown_button_finance.dart';
import '../controller/outgoing_add_controller.dart';

// ignore: must_be_immutable
class OutgoingInsertPage extends StatelessWidget {
  OutgoingInsertPage({
    super.key,
    this.outgoing,
  }) {
    if (outgoing != null) {
      outgoingAddController.updateValue(outgoing!);
    } else {
      outgoingAddController.initDate();
    }
  }

  OutgoingAddController outgoingAddController = OutgoingAddController();
  OutgoingListController outgoingListController = OutgoingListController();
  CategoryListController listCategoryController = CategoryListController();
  FinaceListController finaceListController = FinaceListController();

  Outgoing? outgoing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          outgoing != null ? "Editar despesa" : "Nova despesa",
          style: const TextStyle(
              fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: outgoingAddController.depesasController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormFieldWidget(
                controller:
                    outgoingAddController.textControllerDescricaoDespesa,
                maxLine: 1,
                hintText: 'Descrição',
              ),
              TextFormFieldWidget(
                controller: outgoingAddController.textControllerValorDespesa,
                maxLine: 1,
                hintText: 'Valor',
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter()
                ],
              ),
              FutureBuilder(
                future: finaceListController.getFinanceAll(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Finance>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data!.isNotEmpty) {
                      outgoingAddController.setListFinance(snapshot.data!);

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: const Text(
                              "Finança",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22,
                                  color: Colors.black54),
                            ),
                          ),
                          DropdownButtonFinance(
                            outgoingAddController: outgoingAddController,
                          ),
                        ],
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 30),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Não há finança",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: double.maxFinite,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 15),
                                child: GestureDetector(
                                  onTap: () async {
                                    await Navigator.of(context).push(
                                      TransitionsBuilder.createRoute(
                                        const CategoryPage(index: 2),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 3,
                                          bottom: 3),
                                      child: Text(
                                        '+ Adicionar nova finança',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              FutureBuilder(
                future: listCategoryController.getCategory(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Category>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data!.isNotEmpty) {
                      outgoingAddController.setCategory(snapshot.data!);

                      return Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: const Text(
                              "Categoria",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22,
                                  color: Colors.black54),
                            ),
                          ),
                          DropdownButtoncategory(
                              outgoingAddController: outgoingAddController),
                        ],
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 30),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Não há categoria",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: double.maxFinite,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 15),
                                child: GestureDetector(
                                  onTap: () async {
                                    await Navigator.of(context).push(
                                      TransitionsBuilder.createRoute(
                                        const CategoryPage(index: 2),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 3,
                                          bottom: 3),
                                      child: Text(
                                        '+ Adicionar nova categoria',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: const Text(
                  "Data despesa",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 22,
                      color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextFormFieldWidget(
                  controller: outgoingAddController.textControllerDataDespesa,
                  readOnly: outgoing?.id != null ? true : false,
                  inputFormatter: [DateMask()],
                  keyboardType: TextInputType.datetime,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.date_range,
                    ),
                    color: Colors.black54,
                    iconSize: 22,
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2025),
                      );

                      if (picked != null) {
                        outgoingAddController.setValueDateRevision(picked);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: const Color(0xffffffff),
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButtonWidget(
                label: 'CANCELA', onClick: () => Navigator.pop(context, false)),
            TextButtonWidget(
              label: outgoing != null ? 'EDITAR' : 'SALVAR',
              onClick: () async {
                bool result = await outgoingAddController.validateInput(
                    outgoing?.id, context);
                if (result) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
