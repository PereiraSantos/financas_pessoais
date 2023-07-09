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
  List<Category>? listCategory = [];

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

  Future<List<Outgoing>> getOutgoingAll() async {
    listCategory = await categoryRepository.findAll();
    return await databaseOutgoingRepository.findAll();
  }

  Future<List<Outgoing>> getOutgoingLast(
      {String? value, int? idFinance}) async {
    listCategory = await categoryRepository.findAll();
    return value != null && value != ""
        ? await databaseOutgoingRepository.findOutgoingDescription('%$value%')
        : await databaseOutgoingRepository.findAllIdFinance(idFinance ?? -1);
  }

  Future<Outgoing?> getOutgoingById(int id) async {
    return await databaseOutgoingRepository.findOutgoingById(id);
  }

  Future<Finance?> getFinanceDateFinishIsNull() async =>
      await dataBaseFinanceRepository.findFinanceDateFinishIsNull();

  Future<void> deleteOutgoing(int id, BuildContext context) async {
    databaseOutgoingRepository
        .deleteOutgoingById(id)
        .whenComplete(() => message(context, "Excluido com sucesso!!!"));
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

  Category? getCategory(int id) {
    var element = listCategory?.where((element) => element.id == id);
    return element!.isEmpty ? Category() : element.first;
  }
}
