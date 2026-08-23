import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';

/// Account Types supported by the application
enum AccountType {
  bank,
  creditCard,
  digitalWallet,
  cash;

  String get label {
    switch (this) {
      case AccountType.bank:
        return 'חשבון בנק (עו"ש)';
      case AccountType.creditCard:
        return 'כרטיס אשראי';
      case AccountType.digitalWallet:
        return 'ארנק דיגיטלי';
      case AccountType.cash:
        return 'מזומן';
    }
  }

  IconData get defaultIcon {
    switch (this) {
      case AccountType.bank:
        return AppIcons.bank;
      case AccountType.creditCard:
        return AppIcons.creditCard;
      case AccountType.digitalWallet:
        return AppIcons.wallet;
      case AccountType.cash:
        return AppIcons.cash;
    }
  }

  static AccountType fromString(String val) {
    switch (val) {
      case 'creditCard':
        return AccountType.creditCard;
      case 'digitalWallet':
        return AccountType.digitalWallet;
      case 'cash':
        return AccountType.cash;
      case 'bank':
      default:
        return AccountType.bank;
    }
  }
}

/// Account Domain Model
class AccountModel {
  final String id;
  final String name;
  final AccountType type;
  final String currency;
  final double initialBalance;
  final double currentBalance;
  final String? linkedAccountId;
  final String? linkedAccountName;
  final int? billingDayOfMonth;
  final int colorValue;
  final String iconName;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AccountModel({
    required this.id,
    required this.name,
    required this.type,
    this.currency = 'ILS',
    this.initialBalance = 0.0,
    this.currentBalance = 0.0,
    this.linkedAccountId,
    this.linkedAccountName,
    this.billingDayOfMonth,
    required this.colorValue,
    required this.iconName,
    this.isArchived = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Color get color => Color(colorValue);
  IconData get icon => AppIcons.fromString(iconName, fallback: type.defaultIcon);

  AccountModel copyWith({
    String? id,
    String? name,
    AccountType? type,
    String? currency,
    double? initialBalance,
    double? currentBalance,
    String? linkedAccountId,
    String? linkedAccountName,
    int? billingDayOfMonth,
    int? colorValue,
    String? iconName,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AccountModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      currency: currency ?? this.currency,
      initialBalance: initialBalance ?? this.initialBalance,
      currentBalance: currentBalance ?? this.currentBalance,
      linkedAccountId: linkedAccountId ?? this.linkedAccountId,
      linkedAccountName: linkedAccountName ?? this.linkedAccountName,
      billingDayOfMonth: billingDayOfMonth ?? this.billingDayOfMonth,
      colorValue: colorValue ?? this.colorValue,
      iconName: iconName ?? this.iconName,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
