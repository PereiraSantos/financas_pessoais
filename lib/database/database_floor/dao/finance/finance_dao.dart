import 'package:floor/floor.dart';
import 'package:financas_pessoais/entities/finance/finance.dart';

@dao
abstract class FinanceDao {
  @Query('SELECT * FROM finance')
  Future<List<Finance>> findAll();

  @Query('SELECT * FROM finance order by id desc limit 1')
  Future<Finance?> findLastAll();

  @Query('SELECT * FROM finance where id = :id')
  Future<Finance?> findFinanceById(int id);

  @Query(
      'SELECT * FROM finance where date_finish is null and active = 1 limit 1')
  Future<Finance?> findFinanceDateFinishIsNull();

  @Query(
      'UPDATE finance set date_finish = :dateFinish, active = :active where id = :id')
  Future<Finance?> updateDateFinanceById(
      String dateFinish, bool active, int id);

  @Query('UPDATE finance set value = :value where id = :id')
  Future<void> updateDateFinance(double value, int id);

  @insert
  Future<int> insertFinance(Finance finance);
}
