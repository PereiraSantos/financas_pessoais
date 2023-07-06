import 'package:financas_pessoais/database/database_floor/database_outgoing_floor.dart';
import 'package:financas_pessoais/database/database_outgoing_repository.dart';
import 'package:financas_pessoais/entities/outgoing/outgoing.dart';
import 'package:flutter/material.dart';

import '../../../database/database_finance_repository.dart';
import '../../../database/database_floor/database_finance_floor.dart';
import '../../../entities/finance/finance.dart';

class FinaceListController {
  DataBaseFinanceRepository dataBaseFinanceRepository =
      DataBaseFinanceRepository(DatabaseFinanceFloor());

  Future<Finance?> getFinance(int? idFinance) async {
    return idFinance != null
        ? await dataBaseFinanceRepository.findFinanceById(idFinance)
        : await dataBaseFinanceRepository.findLastAll();
  }

  Future<List<Finance>> getFinanceAll() async {
    return await dataBaseFinanceRepository.findAll();
  }

  Future<Finance?> getFinanceById(int id) async {
    return await dataBaseFinanceRepository.findFinanceById(id);
  }

  Future<void> onClickDelete(BuildContext context, int id) async {
    List<Outgoing> list =
        await DatabaseOutgoingRepository(DatabaseOutgoingFloor())
            .findAllIdFinance(id);
    if (list.isNotEmpty) {
      // ignore: use_build_context_synchronously
      message(
          context, "Esta finança tem despesas vinculada não pode ser excluída");
      return;
    }

    dataBaseFinanceRepository
        .removeFinanceById(id)
        .whenComplete(() => message(context, "Removido com sucesso!!!"));
  }

  void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
