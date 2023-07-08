import 'package:floor/floor.dart';

import '../../../../entities/category/category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM category order by id desc')
  Future<List<Category>> findAll();

  @Query('SELECT * FROM category where id = :id')
  Future<Category?> findCategoryById(int id);

  @Query(
      'UPDATE category set description = :description, emoji = :emoji, color = :color where id = :id')
  Future<Category?> updateCategoryById(
      String description, String emoji, int color, int id);

  @Query('delete FROM category WHERE id = :id')
  Future<void> deleteCategoryById(int id);

  @insert
  Future<int> insertCategory(Category category);
}
