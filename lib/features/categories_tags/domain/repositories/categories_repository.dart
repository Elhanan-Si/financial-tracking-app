import '../models/category_model.dart';
import '../models/merchant_model.dart';
import '../models/tag_model.dart';

/// Repository interface for Categories, Tags, and Merchants
abstract class CategoriesRepository {
  // === CATEGORIES ===
  Stream<List<CategoryModel>> watchCategoryTree({String? type});
  Stream<List<CategoryModel>> watchAllCategories({String? type});
  Future<CategoryModel?> getCategoryById(String id);
  Future<String> createCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
  Future<void> deleteCategory(String categoryId, {String? replacementCategoryId});

  // === TAGS ===
  Stream<List<TagModel>> watchAllTags();
  Future<String> createTag(String name, int colorValue);
  Future<void> deleteTag(String id);

  // === MERCHANTS ===
  Stream<List<MerchantModel>> watchAllMerchants();
  Future<List<MerchantModel>> searchMerchants(String query);
  Future<MerchantModel> findOrCreateMerchant(String name, {String? defaultCategoryId});
  Future<void> updateMerchantDefaultCategory(String merchantId, String? defaultCategoryId);
  Future<void> mergeMerchants({required String sourceMerchantId, required String targetMerchantId});
  Future<void> deleteMerchant(String id);
}
