import '../entities/outgoing/outgoing.dart';
import 'database_floor/database_outgoing_floor.dart';

class DatabaseOutgoingRepository {
  IDatabaseOutgoing database;

  DatabaseOutgoingRepository(this.database);

  Future<void> deleteOutgoingById(int id) async {
    return await database.deleteOutgoingById(id);
  }

  Future<List<Outgoing>> findAll() async {
    return await database.findAll();
  }

  Future<List<Outgoing>> findAllIdFinance(int idFinance) async {
    return await database.findAllIdFinance(idFinance);
  }

  Future<List<Outgoing>> findAllOutgoingByIdFinance(int idFinance) async {
    return await database.findAllOutgoingByIdFinance(idFinance);
  }

  Future<Outgoing?> findOutgoingById(int id) async {
    return await database.findOutgoingById(id);
  }

  Future<List<Outgoing>> findOutgoingDescription(String text) async {
    return await database.findOutgoingDescription(text);
  }

  Future<int> insertOutgoing(Outgoing outgoing) async {
    return await database.insertOutgoing(outgoing);
  }

  Future<void> insertOutgoingList(List<Outgoing> outgoing) async {
    return database.insertOutgoingList(outgoing);
  }

  Future<void> updateOutgoing(String description, double value, String date,
      int id, int idCategory, int idFinance) async {
    return await database.updateOutgoing(
        description, value, date, id, idCategory, idFinance);
  }
}
