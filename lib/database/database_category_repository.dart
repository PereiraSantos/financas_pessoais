import '../entities/category/category.dart';
import 'database_floor/database_category.dart';

class DataBaseCategoryRepository {
  IDatabaseCategory database;

  DataBaseCategoryRepository(this.database);

  Future<List<Category>> findAll() async {
    return await database.findAll();
  }

  Future<Category?> findCategoryById(int id) async {
    return await database.findCategoryById(id);
  }

  Future<Category?> updateCategory(
      String description, String emoji, int color, int id) async {
    return await database.updateCategoryById(description, emoji, color, id);
  }

  Future<int> insertCategory(Category category) async {
    return await database.insertCategory(category);
  }

  Future<void> deleteCategoryById(int id) async {
    return await database.deleteCategoryById(id);
  }
}
