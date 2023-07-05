import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:financas_pessoais/entities/finance/finance.dart';

import '../../../usercase/currency_input_formatter.dart';
import '../../../usercase/date_mask.dart';
import '../../../usercase/format_date.dart';
import '../../../widgets/app_bar_widgets.dart';
import '../../../widgets/text_button_widget.dart';
import '../../../widgets/text_form_field_widget.dart';
import '../controller/finance_insert_controller.dart';

// ignore: must_be_immutable
class FinanceInsertPage extends StatelessWidget {
  FinanceInsertPage({super.key, this.finance}) {
    initElement();
  }

  initElement() async {
    financeInsertController.initDate();

    if (finance != null) {
      financeInsertController.textControllerValorFinanca.text =
          Format.currentFormat(finance!.value!.toString());

      if (finance!.valueSave! > 0.0) {
        financeInsertController.textControllerValorPoupar.text =
            Format.currentFormat(finance!.valueSave!.toString());
      }

      financeInsertController.textControllerDataFinanca.text =
          finance!.dateStart!.toString();
    }
  }

  Finance? finance;
  FinanceInsertController financeInsertController = FinanceInsertController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBarWidgets(
            label: finance != null ? "Editar finança" : "Nova finança"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: financeInsertController.financaControlller,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormFieldWidget(
                controller: financeInsertController.textControllerValorFinanca,
                hintText: 'Valor',
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter()
                ],
              ),
              TextFormFieldWidget(
                controller: financeInsertController.textControllerValorPoupar,
                hintText: 'Guardar',
                keyboardType: TextInputType.number,
                valid: false,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextFormFieldWidget(
                  controller: financeInsertController.textControllerDataFinanca,
                  readOnly: finance?.id != null ? true : false,
                  inputFormatter: [DateMask()],
                  keyboardType: TextInputType.datetime,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.date_range,
                    ),
                    color: Colors.black54,
                    iconSize: 22,
                    onPressed: () async {
                      if (finance?.id == null) {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (picked != null) {
                          financeInsertController.setValueDateRevision(picked);
                        }
                      } else {
                        //outgoingController.message(context, "Não é possivel editar");
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: GestureDetector(
                  onTap: () async {
                    bool result = await financeInsertController
                        .duplicateFinance(context, finance);
                    if (result) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, true);
                    }
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 3, bottom: 3),
                      child: Text(
                        '+ Duplicar finança',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
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
              label: finance?.id != null ? 'EDITAR' : 'SALVAR',
              onClick: () async {
                bool result = await financeInsertController.validateInput(
                    finance?.id, context);
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
