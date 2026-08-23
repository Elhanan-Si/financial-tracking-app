import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';

/// Domain entity for a monthly category budget rule
class BudgetModel {
  final String id;
  final String categoryId;
  final String? categoryName;
  final int? categoryColor;
  final String? categoryIcon;
  final String yearMonth; // 'YYYY-MM'
  final double baseAmount;
  final bool isRolloverEnabled;
  final double? maxRolloverAmount;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BudgetModel({
    required this.id,
    required this.categoryId,
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
    required this.yearMonth,
    required this.baseAmount,
    this.isRolloverEnabled = false,
    this.maxRolloverAmount,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Color get color => categoryColor != null ? Color(categoryColor!) : AppColors.primary;
  IconData get icon => AppIcons.fromString(categoryIcon, fallback: AppIcons.budgets);

  BudgetModel copyWith({
    String? id,
    String? categoryId,
    String? categoryName,
    int? categoryColor,
    String? categoryIcon,
    String? yearMonth,
    double? baseAmount,
    bool? isRolloverEnabled,
    double? maxRolloverAmount,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      yearMonth: yearMonth ?? this.yearMonth,
      baseAmount: baseAmount ?? this.baseAmount,
      isRolloverEnabled: isRolloverEnabled ?? this.isRolloverEnabled,
      maxRolloverAmount: maxRolloverAmount ?? this.maxRolloverAmount,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Calculated model representing real-time budget progress, rollover & burn rate
class BudgetProgressModel {
  final BudgetModel budget;
  final double rolloverBalance; // Surplus (+) or Deficit (-) from previous month
  final double actualSpent; // Sum of expenses for this category in this month (including splits)
  final int daysInMonth;
  final int currentDayOfMonth;

  const BudgetProgressModel({
    required this.budget,
    required this.rolloverBalance,
    required this.actualSpent,
    required this.daysInMonth,
    required this.currentDayOfMonth,
  });

  /// Effective budget = baseAmount + rolloverBalance
  double get effectiveBudget => (budget.baseAmount + rolloverBalance).clamp(0.0, double.infinity);

  /// Remaining amount available in budget
  double get remainingBudget => effectiveBudget - actualSpent;

  /// Percentage utilized (0.0 to 1.0+)
  double get percentageUtilized {
    if (effectiveBudget <= 0) return actualSpent > 0 ? 1.5 : 0.0;
    return actualSpent / effectiveBudget;
  }

  /// Whether budget has exceeded 100%
  bool get isOverBudget => actualSpent > effectiveBudget;

  /// Expected percentage of month passed
  double get expectedMonthProgress => (currentDayOfMonth / daysInMonth).clamp(0.0, 1.0);

  /// Burn Rate status: 'safe', 'warning', 'danger'
  /// Safe: actual % <= expected % + 10%
  /// Warning: actual % > expected % + 10% and <= 100%
  /// Danger: > 100%
  String get burnRateStatus {
    if (percentageUtilized > 1.0) return 'danger';
    if (percentageUtilized > (expectedMonthProgress + 0.15)) return 'warning';
    return 'safe';
  }

  Color get statusColor {
    if (percentageUtilized > 1.0) return AppColors.error;
    if (percentageUtilized >= 0.70) return AppColors.warning;
    return AppColors.success;
  }
}

/// Overall Monthly Budget Summary
class MonthlyBudgetSummary {
  final String yearMonth;
  final double totalPlannedBudget;
  final double totalEffectiveBudget;
  final double totalActualSpent;
  final double totalExpectedIncome;
  final List<BudgetProgressModel> items;

  const MonthlyBudgetSummary({
    required this.yearMonth,
    required this.totalPlannedBudget,
    required this.totalEffectiveBudget,
    required this.totalActualSpent,
    required this.totalExpectedIncome,
    required this.items,
  });

  double get totalRemaining => totalEffectiveBudget - totalActualSpent;
  double get totalPercentageUtilized => totalEffectiveBudget > 0 ? (totalActualSpent / totalEffectiveBudget) : 0.0;
  int get overBudgetCategoriesCount => items.where((i) => i.isOverBudget).length;
}
