/// Merchant Domain Model with default category auto-learning
class MerchantModel {
  final String id;
  final String name;
  final String? defaultCategoryId;
  final String? defaultCategoryName;
  final bool isAutoLearned;
  final int usageCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MerchantModel({
    required this.id,
    required this.name,
    this.defaultCategoryId,
    this.defaultCategoryName,
    this.isAutoLearned = false,
    this.usageCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  MerchantModel copyWith({
    String? id,
    String? name,
    String? defaultCategoryId,
    String? defaultCategoryName,
    bool? isAutoLearned,
    int? usageCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MerchantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultCategoryId: defaultCategoryId ?? this.defaultCategoryId,
      defaultCategoryName: defaultCategoryName ?? this.defaultCategoryName,
      isAutoLearned: isAutoLearned ?? this.isAutoLearned,
      usageCount: usageCount ?? this.usageCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
