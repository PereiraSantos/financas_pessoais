import 'package:floor/floor.dart';

@Entity(tableName: 'finance')
class Finance {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'value')
  double? value;

  @ColumnInfo(name: 'date_start')
  String? dateStart;

  @ColumnInfo(name: 'date_finish')
  String? dateFinish;

  @ColumnInfo(name: 'value_save')
  double? valueSave;

  @ColumnInfo(name: 'active')
  bool? active;

  @ColumnInfo(name: 'repeat')
  bool? repeat;

  Finance({
    this.id,
    this.value,
    this.dateStart,
    this.dateFinish,
    this.valueSave,
    this.repeat,
    this.active,
  });
}
