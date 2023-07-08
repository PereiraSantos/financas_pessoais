import 'package:floor/floor.dart';

@Entity(tableName: 'category')
class Category {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'emoji')
  String? emoji;

  @ColumnInfo(name: 'color')
  int? color;

  @ColumnInfo(name: 'icon')
  String? icon;

  Category({
    this.id,
    this.description,
    this.emoji,
    this.color,
    this.icon,
  });
}
