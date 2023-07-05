import '../../entities/category/category.dart';
import 'database/app_database.dart';
import 'database/instance_database.dart';

abstract class IDatabaseCategory {
  Future<List<Category>> findAll();
  Future<Category?> findCategoryById(int id);
  Future<Category?> updateCategoryById(String description, int color, int id);
  Future<int> insertCategory(Category finance);
  Future<void> deleteCategoryById(int id);
}

class DatabaseCategoryFloor implements IDatabaseCategory {
  AppDatabase? _database;

  @override
  Future<List<Category>> findAll() async {
    await validInstanceDataBase();
    return await _database!.categoryDao.findAll();
  }

  @override
  Future<Category?> findCategoryById(int id) async {
    await validInstanceDataBase();
    return await _database!.categoryDao.findCategoryById(id);
  }

  @override
  Future<Category?> updateCategoryById(
      String description, int color, int id) async {
    await validInstanceDataBase();
    return await _database!.categoryDao
        .updateCategoryById(description, color, id);
  }

  @override
  Future<int> insertCategory(Category category) async {
    await validInstanceDataBase();
    return await _database!.categoryDao.insertCategory(category);
  }

  @override
  Future<void> deleteCategoryById(int id) async {
    await validInstanceDataBase();
    return await _database!.categoryDao.deleteCategoryById(id);
  }

  Future<void> validInstanceDataBase() async {
    _database ??= await InstanceFloor().getInstance();
  }
}
