import 'package:flutter/material.dart';
import 'package:financas_pessoais/entities/outgoing/outgoing.dart';

import '../../../database/database_floor/database_outgoing_floor.dart';
import '../../../database/database_outgoing_repository.dart';
import '../../../entities/category/category.dart';
import '../../../entities/finance/finance.dart';
import '../../../usercase/format_date.dart';

class OutgoingAddController {
  final depesasController = GlobalKey<FormState>();
  final textControllerDescricaoDespesa = TextEditingController();
  final textControllerDataDespesa = TextEditingController();
  final textControllerValorDespesa = TextEditingController();
  final textController = TextEditingController();

  int? idFinance;
  List<Finance> finance = [];
  int? idCategory;
  List<Category> category = [];

  DatabaseOutgoingRepository databaseOutgoingRepository =
      DatabaseOutgoingRepository(DatabaseOutgoingFloor());

  void setListFinance(List<Finance> element) {
    finance = element;
    setFinance(element[0].id!);
  }

  void setFinance(int value) => idFinance = value;

  void setCategory(List<Category> element) {
    category = element;
    setColor(element[0].id!);
  }

  void setColor(int value) => idCategory = value;

  Future<bool> validateInput(
      int? id, BuildContext context, List<Outgoing>? listOutgoing) async {
    if (depesasController.currentState!.validate() && idFinance != null) {
      id != null
          ? await updateOutgoing(id, context)
          : await insertOutgoing(context, listOutgoing);

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
            id,
            idCategory ?? 0,
            idFinance!)
        .whenComplete(() => message(context, "Atualizado com sucesso!!!"));
  }

  Future<void> insertOutgoing(
      BuildContext context, List<Outgoing>? listOutgoing) async {
    if (listOutgoing != null) {
      final List<Outgoing> list = buildOutgoingList(listOutgoing);
      await databaseOutgoingRepository
          .insertOutgoingList(list)
          .whenComplete(() => message(context, "Registrado com sucesso!!!"));
    } else {
      final outgoing = buildOutgoing();
      await databaseOutgoingRepository
          .insertOutgoing(outgoing)
          .whenComplete(() => message(context, "Registrado com sucesso!!!"));
    }
  }

  List<Outgoing> buildOutgoingList(List<Outgoing> listOutgoing) {
    List<Outgoing> list = [];
    for (var element in listOutgoing) {
      list.add(
        Outgoing(
            date: element.date,
            description: element.description,
            idFinance: idFinance,
            value: element.value,
            idCategory: idCategory),
      );
    }

    return list;
  }

  Outgoing buildOutgoing() {
    return Outgoing(
        date: textControllerDataDespesa.text,
        description: textControllerDescricaoDespesa.text,
        idFinance: idFinance,
        value: preparaValor(textControllerValorDespesa.text),
        idCategory: idCategory);
  }

  double preparaValor(value) {
    if (value.toString().length < 10) {
      return double.parse(value.replaceAll("R\$", "").replaceAll(",", "."));
    } else {
      try {
        return double.parse(value
            .replaceAll("R\$", "")
            .replaceAll(".", "")
            .replaceAll(",00", ".0"));
      } catch (e) {
        return double.parse(value
            .replaceAll("R\$", "")
            .replaceAll(".", "")
            .replaceAll(",", "")
            .replaceAll(",00", ".0"));
      }
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
