import 'package:floor/floor.dart';

import '../../../../entities/category/category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM category')
  Future<List<Category>> findAll();

  @Query('SELECT * FROM category where id = :id')
  Future<Category?> findCategoryById(int id);

  @Query(
      'UPDATE category set description = :description, color = :color where id = :id')
  Future<Category?> updateCategoryById(String description, int color, int id);

  @Query('delete FROM category WHERE id = :id')
  Future<void> deleteCategoryById(int id);

  @insert
  Future<int> insertCategory(Category category);
}
