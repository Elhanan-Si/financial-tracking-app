import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';

/// Spending classification type (Needs vs Wants)
enum SpendingClassification {
  needs,
  wants;

  String get label => this == needs ? 'צרכים בסיסיים' : 'מותרות';

  static SpendingClassification fromString(String? val) {
    if (val == 'wants') return SpendingClassification.wants;
    return SpendingClassification.needs;
  }
}

/// Flexibility type (Fixed vs Variable)
enum CategoryFlexibility {
  fixed,
  variable;

  String get label => this == fixed ? 'הוצאה קבועה' : 'הוצאה משתנה';

  static CategoryFlexibility fromString(String? val) {
    if (val == 'fixed') return CategoryFlexibility.fixed;
    return CategoryFlexibility.variable;
  }
}

/// Category Domain Model with support for hierarchical parent-child trees
class CategoryModel {
  final String id;
  final String? parentId;
  final String name;
  final String type; // 'expense', 'income'
  final SpendingClassification spendingClassification;
  final CategoryFlexibility flexibility;
  final int colorValue;
  final String iconName;
  final bool isDefault;
  final bool isArchived;
  final List<CategoryModel> subcategories;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryModel({
    required this.id,
    this.parentId,
    required this.name,
    required this.type,
    this.spendingClassification = SpendingClassification.needs,
    this.flexibility = CategoryFlexibility.variable,
    required this.colorValue,
    required this.iconName,
    this.isDefault = false,
    this.isArchived = false,
    this.subcategories = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isParent => parentId == null;
  bool get isExpense => type == 'expense';
  bool get isIncome => type == 'income';

  Color get color => Color(colorValue);
  IconData get icon => AppIcons.fromString(iconName);
  bool get isNeeds => spendingClassification == SpendingClassification.needs;
  bool get isWants => spendingClassification == SpendingClassification.wants;

  CategoryModel copyWith({
    String? id,
    String? parentId,
    String? name,
    String? type,
    SpendingClassification? spendingClassification,
    CategoryFlexibility? flexibility,
    int? colorValue,
    String? iconName,
    bool? isDefault,
    bool? isArchived,
    List<CategoryModel>? subcategories,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      type: type ?? this.type,
      spendingClassification: spendingClassification ?? this.spendingClassification,
      flexibility: flexibility ?? this.flexibility,
      colorValue: colorValue ?? this.colorValue,
      iconName: iconName ?? this.iconName,
      isDefault: isDefault ?? this.isDefault,
      isArchived: isArchived ?? this.isArchived,
      subcategories: subcategories ?? this.subcategories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
