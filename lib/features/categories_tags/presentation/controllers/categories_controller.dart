import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../data/repositories/categories_repository_impl.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/merchant_model.dart';
import '../../domain/models/tag_model.dart';
import '../../domain/repositories/categories_repository.dart';

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return CategoriesRepositoryImpl(db);
});

final categoryTreeStreamProvider = StreamProvider.family<List<CategoryModel>, String?>((ref, type) {
  final repo = ref.watch(categoriesRepositoryProvider);
  return repo.watchCategoryTree(type: type);
});

final allCategoriesStreamProvider = StreamProvider.family<List<CategoryModel>, String?>((ref, type) {
  final repo = ref.watch(categoriesRepositoryProvider);
  return repo.watchAllCategories(type: type);
});

final tagsStreamProvider = StreamProvider<List<TagModel>>((ref) {
  final repo = ref.watch(categoriesRepositoryProvider);
  return repo.watchAllTags();
});

final merchantsStreamProvider = StreamProvider<List<MerchantModel>>((ref) {
  final repo = ref.watch(categoriesRepositoryProvider);
  return repo.watchAllMerchants();
});

final categoriesControllerProvider = Provider<CategoriesController>((ref) {
  final repo = ref.watch(categoriesRepositoryProvider);
  return CategoriesController(repo);
});

class CategoriesController {
  final CategoriesRepository _repo;

  CategoriesController(this._repo);

  Future<String> createCategory({
    required String name,
    String? parentId,
    required String type,
    required SpendingClassification classification,
    required CategoryFlexibility flexibility,
    required int colorValue,
    required String iconName,
  }) async {
    final cat = CategoryModel(
      id: '',
      parentId: parentId,
      name: name.trim(),
      type: type,
      spendingClassification: classification,
      flexibility: flexibility,
      colorValue: colorValue,
      iconName: iconName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return await _repo.createCategory(cat);
  }

  Future<void> updateCategory(CategoryModel category) async {
    await _repo.updateCategory(category);
  }

  Future<void> deleteCategory(String categoryId, {String? replacementCategoryId}) async {
    await _repo.deleteCategory(categoryId, replacementCategoryId: replacementCategoryId);
  }

  Future<String> createTag(String name, int colorValue) async {
    return await _repo.createTag(name.trim(), colorValue);
  }

  Future<void> deleteTag(String id) async {
    await _repo.deleteTag(id);
  }

  Future<void> updateMerchantDefaultCategory(String merchantId, String? defaultCategoryId) async {
    await _repo.updateMerchantDefaultCategory(merchantId, defaultCategoryId);
  }

  Future<void> mergeMerchants({required String sourceMerchantId, required String targetMerchantId}) async {
    await _repo.mergeMerchants(sourceMerchantId: sourceMerchantId, targetMerchantId: targetMerchantId);
  }

  Future<void> deleteMerchant(String id) async {
    await _repo.deleteMerchant(id);
  }
}
