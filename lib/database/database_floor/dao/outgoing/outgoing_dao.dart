import 'package:floor/floor.dart';
import 'package:financas_pessoais/entities/outgoing/outgoing.dart';

@dao
abstract class OutgoingDao {
  @Query('SELECT * FROM outgoing')
  Future<List<Outgoing>> findAll();

  @Query(
      'SELECT * FROM outgoing where id_finance = :idFinance order by id desc limit 5')
  Future<List<Outgoing>> findAllIdFinance(int idFinance);

  @Query('SELECT * FROM outgoing where id_finance = :idFinance')
  Future<List<Outgoing>> findAllOutgoingByIdFinance(int idFinance);

  @Query('SELECT * FROM outgoing WHERE description LIKE :text')
  Future<List<Outgoing>> findOutgoingDescription(String text);

  @Query('delete FROM outgoing WHERE id = :id')
  Future<void> deleteOutgoingById(int id);

  @Query('SELECT * FROM outgoing WHERE id = :id')
  Future<Outgoing?> findOutgoingById(int id);

  @Query(
      'update outgoing set description = :description,  value = :value, date = :date, id_category = :idCategory,  id_finance = :idFinance WHERE id = :id')
  Future<void> updateOutgoing(String description, double value, String date,
      int id, int idCategory, int idFinance);

  @insert
  Future<int> insertOutgoing(Outgoing outgoing);

  @insert
  Future<void> insertOutgoingList(List<Outgoing> outgoing);
}
