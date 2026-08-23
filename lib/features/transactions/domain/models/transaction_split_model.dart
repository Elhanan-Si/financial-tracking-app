import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';

/// Transaction Split Domain Model
class TransactionSplitModel {
  final String id;
  final String transactionId;
  final String categoryId;
  final String? categoryName;
  final int? categoryColor;
  final String? categoryIcon;
  final double amount;
  final String? note;
  final DateTime createdAt;

  const TransactionSplitModel({
    required this.id,
    required this.transactionId,
    required this.categoryId,
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
    required this.amount,
    this.note,
    required this.createdAt,
  });

  Color get color => categoryColor != null ? Color(categoryColor!) : AppColors.primary;
  IconData get icon => categoryIcon != null ? AppIcons.fromString(categoryIcon!) : AppIcons.uncategorized;

  TransactionSplitModel copyWith({
    String? id,
    String? transactionId,
    String? categoryId,
    String? categoryName,
    int? categoryColor,
    String? categoryIcon,
    double? amount,
    String? note,
    DateTime? createdAt,
  }) {
    return TransactionSplitModel(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
