import 'package:flutter/material.dart';
import 'package:financas_pessoais/database/database_category_repository.dart';
import 'package:financas_pessoais/database/database_finance_repository.dart';
import 'package:financas_pessoais/database/database_floor/database_category.dart';
import 'package:financas_pessoais/database/database_floor/database_finance_floor.dart';

import '../../../database/database_floor/database_outgoing_floor.dart';
import '../../../database/database_outgoing_repository.dart';
import '../../../entities/category/category.dart';
import '../../../entities/finance/finance.dart';
import '../../../entities/outgoing/outgoing.dart';
import '../../../usercase/format_date.dart';

class OutgoingListController {
  final depesasController = GlobalKey<FormState>();
  final textControllerDescricaoDespesa = TextEditingController();
  final textControllerDataDespesa = TextEditingController();
  final textControllerValorDespesa = TextEditingController();
  final textController = TextEditingController();

  int? idFinance;

  DatabaseOutgoingRepository databaseOutgoingRepository =
      DatabaseOutgoingRepository(DatabaseOutgoingFloor());

  DataBaseFinanceRepository dataBaseFinanceRepository =
      DataBaseFinanceRepository(DatabaseFinanceFloor());

  DataBaseCategoryRepository categoryRepository =
      DataBaseCategoryRepository(DatabaseCategoryFloor());

  Future<List<Outgoing>> findAllOutgoingByIdFinance(int id) async =>
      await databaseOutgoingRepository.findAllOutgoingByIdFinance(id);

  Future<List<Outgoing>> getOutgoing({String? value, int? idFinance}) async {
    return value != null && value != ""
        ? await databaseOutgoingRepository.findOutgoingDescription('%$value%')
        : await databaseOutgoingRepository.findAllIdFinance(idFinance!);
  }

  Future<List<Outgoing>> getOutgoingAll() async =>
      await databaseOutgoingRepository.findAll();

  Future<List<Outgoing>> getOutgoingLast(
      {String? value, int? idFinance}) async {
    return value != null && value != ""
        ? await databaseOutgoingRepository.findOutgoingDescription('%$value%')
        : await databaseOutgoingRepository.findAllIdFinance(idFinance ?? -1);
  }

  Future<Outgoing?> getOutgoingById(int id) async {
    return await databaseOutgoingRepository.findOutgoingById(id);
  }

  Future<Finance?> getFinanceDateFinishIsNull() async =>
      await dataBaseFinanceRepository.findFinanceDateFinishIsNull();

  Future<bool> validateInput(int? id, BuildContext context) async {
    if (depesasController.currentState!.validate()) {
      Finance? finance = await getFinanceDateFinishIsNull();

      if (finance == null) {
        // ignore: use_build_context_synchronously
        message(context, "Não há finanças cadastrada!!!");
        return Future.value(false);
      }
      id != null
          // ignore: use_build_context_synchronously
          ? await updateOutgoing(id, context)
          // ignore: use_build_context_synchronously
          : await insertOutgoing(context, finance);

      return await Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> insertByListOutgoing(
      List<Outgoing> list, BuildContext context) async {
    databaseOutgoingRepository
        .insertOutgoingList(list)
        .whenComplete(() => message(context, "Registrado com sucesso!!!"));

    return Future.value(true);
  }

  Future<void> updateOutgoing(int id, BuildContext context) async {
    await databaseOutgoingRepository
        .updateOutgoing(
            textControllerDescricaoDespesa.text,
            preparaValor(textControllerValorDespesa.text),
            textControllerDataDespesa.text,
            id)
        .whenComplete(() => message(context, "Atualizado com sucesso!!!"));
  }

  Future<void> insertOutgoing(BuildContext context, Finance finance) async {
    final outgoing = buildOutgoing(finance);
    await databaseOutgoingRepository
        .insertOutgoing(outgoing)
        .whenComplete(() => message(context, "Registrado com sucesso!!!"));
  }

  Outgoing buildOutgoing(Finance finance) {
    return Outgoing(
      date: textControllerDataDespesa.text,
      description: textControllerDescricaoDespesa.text,
      idFinance: finance.id,
      value: preparaValor(textControllerValorDespesa.text),
    );
  }

  double preparaValor(value) {
    if (value.toString().length < 10) {
      return double.parse(value.replaceAll("R\$", "").replaceAll(",", "."));
    } else {
      return double.parse(value
          .replaceAll("R\$", "")
          .replaceAll(".", "")
          .replaceAll(",00", ".0"));
    }
  }

  Future<void> deleteOutgoing(int id, BuildContext context) async {
    databaseOutgoingRepository
        .deleteOutgoingById(id)
        .whenComplete(() => message(context, "Excluido com sucesso!!!"));
  }

  void updateValue(Outgoing outgoing) {
    textControllerDescricaoDespesa.text = outgoing.description!;
    textControllerDataDespesa.text = outgoing.date!;
    textControllerValorDespesa.text = outgoing.value.toString();
  }

  void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  setValueDateRevision(DateTime value) =>
      textControllerDataDespesa.text = Format.formatDate(value);

  initDate() =>
      textControllerDataDespesa.text = Format.formatDate(DateTime.now());
}
