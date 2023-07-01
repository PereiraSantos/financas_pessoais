import '../entities/finance/finance.dart';
import 'database_floor/database_finance_floor.dart';

class DataBaseFinanceRepository {
  IDatabaseFinance database;

  DataBaseFinanceRepository(this.database);

  Future<List<Finance>> findAll() async {
    return await database.findAll();
  }

  Future<Finance?> findFinanceById(int id) async {
    return await database.findFinanceById(id);
  }

  Future<Finance?> findFinanceDateFinishIsNull() async {
    return await database.findFinanceDateFinishIsNull();
  }

  Future<Finance?> findLastAll() async {
    return await database.findLastAll();
  }

  Future<int> insertFinance(Finance finance) async {
    return await database.insertFinance(finance);
  }

  Future<Finance?> updateDateFinanceById(
      String dateFinish, bool active, int id) async {
    return await database.updateDateFinanceById(dateFinish, active, id);
  }

  Future<void> updateFinance(double value, int id) async {
    return await database.updateFinance(value, id);
  }
}
