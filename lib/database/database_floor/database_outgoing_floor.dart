import '../../entities/outgoing/outgoing.dart';

import 'database/app_database.dart';
import 'database/instance_database.dart';

abstract class IDatabaseOutgoing {
  Future<List<Outgoing>> findAll();
  Future<List<Outgoing>> findAllIdFinance(int idFinance);
  Future<List<Outgoing>> findAllOutgoingByIdFinance(int idFinance);
  Future<List<Outgoing>> findOutgoingDescription(String text);
  Future<void> deleteOutgoingById(int id);
  Future<Outgoing?> findOutgoingById(int id);
  Future<void> updateOutgoing(
      String description, double value, String date, int id);
  Future<int> insertOutgoing(Outgoing outgoing);
  Future<void> insertOutgoingList(List<Outgoing> outgoing);
}

class DatabaseOutgoingFloor implements IDatabaseOutgoing {
  AppDatabase? _database;

  @override
  Future<void> deleteOutgoingById(int id) async {
    await validInstanceDataBase();
    return await _database!.outgoingDao.deleteOutgoingById(id);
  }

  @override
  Future<List<Outgoing>> findAll() async {
    await validInstanceDataBase();
    return await _database!.outgoingDao.findAll();
  }

  @override
  Future<List<Outgoing>> findAllIdFinance(int idFinance) async {
    await validInstanceDataBase();
    return await _database!.outgoingDao.findAllIdFinance(idFinance);
  }

  @override
  Future<List<Outgoing>> findAllOutgoingByIdFinance(int idFinance) async {
    await validInstanceDataBase();
    return await _database!.outgoingDao.findAllOutgoingByIdFinance(idFinance);
  }

  @override
  Future<Outgoing?> findOutgoingById(int id) async {
    await validInstanceDataBase();
    return await _database!.outgoingDao.findOutgoingById(id);
  }

  @override
  Future<List<Outgoing>> findOutgoingDescription(String text) async {
    await validInstanceDataBase();
    return await _database!.outgoingDao.findOutgoingDescription(text);
  }

  @override
  Future<int> insertOutgoing(Outgoing outgoing) async {
    await validInstanceDataBase();
    return await _database!.outgoingDao.insertOutgoing(outgoing);
  }

  @override
  Future<void> insertOutgoingList(List<Outgoing> outgoing) async {
    await validInstanceDataBase();
    return _database!.outgoingDao.insertOutgoingList(outgoing);
  }

  @override
  Future<void> updateOutgoing(
      String description, double value, String date, int id) async {
    await validInstanceDataBase();
    return await _database!.outgoingDao
        .updateOutgoing(description, value, date, id);
  }

  Future<void> validInstanceDataBase() async =>
      _database ??= await InstanceFloor().getInstance();
}
