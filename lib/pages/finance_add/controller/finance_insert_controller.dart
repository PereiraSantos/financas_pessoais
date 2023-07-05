import 'package:flutter/material.dart';

import '../../../database/database_floor/database_finance_floor.dart';
import '../../../database/database_finance_repository.dart';
import '../../../entities/finance/finance.dart';
import '../../../usercase/format_date.dart';
import 'dart:developer';

class FinanceInsertController {
  final financaControlller = GlobalKey<FormState>();
  final textControllerValorFinanca = TextEditingController();
  final textControllerDataFinanca = TextEditingController();
  final textControllerValorPoupar = TextEditingController();

  DataBaseFinanceRepository dataBaseFinanceRepository =
      DataBaseFinanceRepository(DatabaseFinanceFloor());

  Future<bool> validateInput(int? id, BuildContext context) async {
    if (financaControlller.currentState!.validate()) {
      id != null
          ? await updateFinance(id, context)
          : await insertFinance(context, id);

      return await Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> duplicateFinance(BuildContext context, Finance? finance) async {
    textControllerValorFinanca.text = finance?.value.toString() ?? '';
    textControllerValorPoupar.text = finance?.valueSave.toString() ?? '';
    initDate();
    return await validateInput(null, context);
  }

  Future<void> insertFinance(BuildContext context, int? idFinance) async {
    try {
      Finance? finance =
          await dataBaseFinanceRepository.findFinanceDateFinishIsNull();

      if (finance != null) {
        await dataBaseFinanceRepository.updateDateFinanceById(
            Format.formatDate(Format.dateParse(textControllerDataFinanca.text)),
            false,
            finance.id!);
      }

      finance = buildFinance();

      await dataBaseFinanceRepository
          .insertFinance(finance)
          .whenComplete(() => message(context, "Registrado com sucesso!!!"));
    } catch (e) {
      log(e.toString());
    }
  }

  double preparaValor(value) {
    if (value == "") return 0;
    if (value.toString().length < 10) {
      return double.parse(value.replaceAll("R\$", "").replaceAll(",", "."));
    } else {
      return double.parse(value
          .replaceAll("R\$", "")
          .replaceAll(".", "")
          .replaceAll(",00", ".0"));
    }
  }

  Finance buildFinance() {
    return Finance(
      value: preparaValor(textControllerValorFinanca.text),
      valueSave: preparaValor(textControllerValorPoupar.text),
      dateStart: textControllerDataFinanca.text,
      active: true,
    );
  }

  void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void setValueDateRevision(DateTime value) =>
      textControllerDataFinanca.text = Format.formatDate(value);

  void initDate() =>
      textControllerDataFinanca.text = Format.formatDate(DateTime.now());

  Future<void> updateFinance(int id, BuildContext context) async {
    dataBaseFinanceRepository.updateFinance(
        preparaValor(textControllerValorFinanca.text), id);
  }
}
