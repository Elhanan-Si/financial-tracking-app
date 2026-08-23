import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';

/// Transaction Types
enum TransactionType {
  expense,
  income,
  transfer;

  String get label {
    switch (this) {
      case TransactionType.expense:
        return 'הוצאה';
      case TransactionType.income:
        return 'הכנסה';
      case TransactionType.transfer:
        return 'העברה פנימית';
    }
  }

  Color get color {
    switch (this) {
      case TransactionType.expense:
        return AppColors.expense;
      case TransactionType.income:
        return AppColors.income;
      case TransactionType.transfer:
        return AppColors.transfer;
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionType.expense:
        return AppIcons.expense;
      case TransactionType.income:
        return AppIcons.income;
      case TransactionType.transfer:
        return AppIcons.transfer;
    }
  }

  static TransactionType fromString(String val) {
    switch (val) {
      case 'income':
        return TransactionType.income;
      case 'transfer':
        return TransactionType.transfer;
      case 'expense':
      default:
        return TransactionType.expense;
    }
  }
}

/// Transaction Domain Model
class TransactionModel {
  final String id;
  final String accountId;
  final String? accountName;
  final String? categoryId;
  final String? categoryName;
  final int? categoryColor;
  final String? categoryIcon;
  final String? merchantId;
  final String? merchantName;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final String? note;
  final bool isExcludedFromReports;
  final bool hasSplits;
  final bool isRecurringInstance;
  final String? recurringRuleId;
  final String? installmentPlanId;
  final int? installmentNumber;
  final String? transferLinkId;
  final bool isAutoCategorized;
  final String originalCurrency;
  final double? originalAmount;
  final double exchangeRateToIls;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionModel({
    required this.id,
    required this.accountId,
    this.accountName,
    this.categoryId,
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
    this.merchantId,
    this.merchantName,
    required this.amount,
    required this.type,
    required this.date,
    this.note,
    this.isExcludedFromReports = false,
    this.hasSplits = false,
    this.isRecurringInstance = false,
    this.recurringRuleId,
    this.installmentPlanId,
    this.installmentNumber,
    this.transferLinkId,
    this.isAutoCategorized = false,
    this.originalCurrency = 'ILS',
    this.originalAmount,
    this.exchangeRateToIls = 1.0,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isExpense => type == TransactionType.expense;
  bool get isIncome => type == TransactionType.income;
  bool get isTransfer => type == TransactionType.transfer;

  Color get displayColor => type.color;
  IconData get displayIcon {
    if (categoryIcon != null && categoryIcon!.isNotEmpty) {
      return AppIcons.fromString(categoryIcon!, fallback: type.icon);
    }
    return type.icon;
  }

  TransactionModel copyWith({
    String? id,
    String? accountId,
    String? accountName,
    String? categoryId,
    String? categoryName,
    int? categoryColor,
    String? categoryIcon,
    String? merchantId,
    String? merchantName,
    double? amount,
    TransactionType? type,
    DateTime? date,
    String? note,
    bool? isExcludedFromReports,
    bool? hasSplits,
    bool? isRecurringInstance,
    String? recurringRuleId,
    String? installmentPlanId,
    int? installmentNumber,
    String? transferLinkId,
    bool? isAutoCategorized,
    String? originalCurrency,
    double? originalAmount,
    double? exchangeRateToIls,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      accountName: accountName ?? this.accountName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      merchantId: merchantId ?? this.merchantId,
      merchantName: merchantName ?? this.merchantName,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      note: note ?? this.note,
      isExcludedFromReports: isExcludedFromReports ?? this.isExcludedFromReports,
      hasSplits: hasSplits ?? this.hasSplits,
      isRecurringInstance: isRecurringInstance ?? this.isRecurringInstance,
      recurringRuleId: recurringRuleId ?? this.recurringRuleId,
      installmentPlanId: installmentPlanId ?? this.installmentPlanId,
      installmentNumber: installmentNumber ?? this.installmentNumber,
      transferLinkId: transferLinkId ?? this.transferLinkId,
      isAutoCategorized: isAutoCategorized ?? this.isAutoCategorized,
      originalCurrency: originalCurrency ?? this.originalCurrency,
      originalAmount: originalAmount ?? this.originalAmount,
      exchangeRateToIls: exchangeRateToIls ?? this.exchangeRateToIls,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
