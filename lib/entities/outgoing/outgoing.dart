import 'package:floor/floor.dart';

@Entity(tableName: 'outgoing')
class Outgoing {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'value')
  double? value;

  @ColumnInfo(name: 'date')
  String? date;

  @ColumnInfo(name: 'color')
  int? color;

  @ColumnInfo(name: 'id_finance')
  int? idFinance;

  Outgoing({
    this.id,
    this.description,
    this.value,
    this.date,
    this.color,
    this.idFinance,
  });
}
