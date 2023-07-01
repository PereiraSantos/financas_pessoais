import '../../../database/database_category_repository.dart';
import '../../../database/database_floor/database_category.dart';
import '../../../entities/category/category.dart';

class CategoryListController {
  DataBaseCategoryRepository dataBaseCategoryRepository =
      DataBaseCategoryRepository(DatabaseCategoryFloor());

  Future<List<Category>> getCategory() async {
    return await dataBaseCategoryRepository.findAll();
  }

  Future<Category?> getCategoryById(int id) async {
    return await dataBaseCategoryRepository.findCategoryById(id);
  }
}
