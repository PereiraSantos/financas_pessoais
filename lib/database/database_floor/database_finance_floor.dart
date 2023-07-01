import '../../entities/finance/finance.dart';
import 'database/app_database.dart';
import 'database/instance_database.dart';

abstract class IDatabaseFinance {
  Future<List<Finance>> findAll();
  Future<Finance?> findLastAll();
  Future<Finance?> findFinanceById(int id);
  Future<Finance?> findFinanceDateFinishIsNull();
  Future<Finance?> updateDateFinanceById(
      String dateFinish, bool active, int id);
  Future<int> insertFinance(Finance finance);
  Future<void> updateFinance(double value, int id);
}

class DatabaseFinanceFloor implements IDatabaseFinance {
  AppDatabase? _database;

  @override
  Future<List<Finance>> findAll() async {
    await validInstanceDataBase();
    return await _database!.financeDao.findAll();
  }

  @override
  Future<Finance?> findFinanceById(int id) async {
    await validInstanceDataBase();
    return await _database!.financeDao.findFinanceById(id);
  }

  @override
  Future<Finance?> findFinanceDateFinishIsNull() async {
    await validInstanceDataBase();
    return await _database!.financeDao.findFinanceDateFinishIsNull();
  }

  @override
  Future<Finance?> findLastAll() async {
    await validInstanceDataBase();
    return await _database!.financeDao.findLastAll();
  }

  @override
  Future<int> insertFinance(Finance finance) async {
    await validInstanceDataBase();
    return await _database!.financeDao.insertFinance(finance);
  }

  @override
  Future<Finance?> updateDateFinanceById(
      String dateFinish, bool active, int id) async {
    await validInstanceDataBase();
    return await _database!.financeDao
        .updateDateFinanceById(dateFinish, active, id);
  }

  @override
  Future<void> updateFinance(double value, int id) async {
    await validInstanceDataBase();
    return await _database!.financeDao.updateDateFinance(value, id);
  }

  Future<void> validInstanceDataBase() async {
    _database ??= await InstanceFloor().getInstance();
  }
}

//
