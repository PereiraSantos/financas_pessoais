import 'package:floor/floor.dart';

@Entity(tableName: 'category')
class Category {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'color')
  int? color;

  @ColumnInfo(name: 'icon')
  String? icon;

  Category({
    this.id,
    this.description,
    this.color,
    this.icon,
  });
}
