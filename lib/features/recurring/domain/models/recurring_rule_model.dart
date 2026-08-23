import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';

enum RecurringFrequency {
  monthly('חודשי', 1),
  biMonthly('דו-חודשי', 2),
  quarterly('רבעוני', 3),
  yearly('שנתי', 12);

  final String label;
  final int monthsInterval;
  const RecurringFrequency(this.label, this.monthsInterval);

  static RecurringFrequency fromString(String value) {
    switch (value) {
      case 'bi_monthly':
        return RecurringFrequency.biMonthly;
      case 'quarterly':
        return RecurringFrequency.quarterly;
      case 'yearly':
        return RecurringFrequency.yearly;
      case 'monthly':
      default:
        return RecurringFrequency.monthly;
    }
  }

  String get dbValue {
    switch (this) {
      case RecurringFrequency.biMonthly:
        return 'bi_monthly';
      case RecurringFrequency.quarterly:
        return 'quarterly';
      case RecurringFrequency.yearly:
        return 'yearly';
      case RecurringFrequency.monthly:
        return 'monthly';
    }
  }
}

/// Recurring Rule (Standing Order / Subscription) Domain Model
class RecurringRuleModel {
  final String id;
  final String accountId;
  final String? accountName;
  final String? categoryId;
  final String? categoryName;
  final int? categoryColor;
  final String? categoryIcon;
  final String? merchantId;
  final String? merchantName;
  final String name;
  final double amount;
  final RecurringFrequency frequency;
  final int dayOfMonth;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isAutoExecute;
  final bool isPaused;
  final DateTime? lastExecutedDate;
  final DateTime nextExecutionDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RecurringRuleModel({
    required this.id,
    required this.accountId,
    this.accountName,
    this.categoryId,
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
    this.merchantId,
    this.merchantName,
    required this.name,
    required this.amount,
    required this.frequency,
    required this.dayOfMonth,
    required this.startDate,
    this.endDate,
    this.isAutoExecute = true,
    this.isPaused = false,
    this.lastExecutedDate,
    required this.nextExecutionDate,
    required this.createdAt,
    required this.updatedAt,
  });

  Color get color => isIncome ? AppColors.income : (categoryColor != null ? Color(categoryColor!) : AppColors.primary);
  IconData get icon => isIncome ? AppIcons.salary : (categoryIcon != null ? AppIcons.fromString(categoryIcon!) : AppIcons.recurring);

  bool get isIncome =>
      name.contains('משכורת') ||
      name.contains('שכר') ||
      name.contains('הכנסה') ||
      name.contains('קצבה') ||
      (categoryName != null &&
          (categoryName!.contains('משכורת') ||
              categoryName!.contains('שכר') ||
              categoryName!.contains('הכנסה') ||
              categoryName!.contains('קצבה')));

  /// Monthly normalized expense for budget forecasting
  double get monthlyNormalizedAmount {
    switch (frequency) {
      case RecurringFrequency.monthly:
        return amount;
      case RecurringFrequency.biMonthly:
        return amount / 2.0;
      case RecurringFrequency.quarterly:
        return amount / 3.0;
      case RecurringFrequency.yearly:
        return amount / 12.0;
    }
  }

  RecurringRuleModel copyWith({
    String? id,
    String? accountId,
    String? accountName,
    String? categoryId,
    String? categoryName,
    int? categoryColor,
    String? categoryIcon,
    String? merchantId,
    String? merchantName,
    String? name,
    double? amount,
    RecurringFrequency? frequency,
    int? dayOfMonth,
    DateTime? startDate,
    DateTime? endDate,
    bool? isAutoExecute,
    bool? isPaused,
    DateTime? lastExecutedDate,
    DateTime? nextExecutionDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RecurringRuleModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      accountName: accountName ?? this.accountName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      merchantId: merchantId ?? this.merchantId,
      merchantName: merchantName ?? this.merchantName,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      frequency: frequency ?? this.frequency,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isAutoExecute: isAutoExecute ?? this.isAutoExecute,
      isPaused: isPaused ?? this.isPaused,
      lastExecutedDate: lastExecutedDate ?? this.lastExecutedDate,
      nextExecutionDate: nextExecutionDate ?? this.nextExecutionDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
