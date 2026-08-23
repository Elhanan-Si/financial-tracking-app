import 'package:flutter/material.dart';

/// Forecast summary for a single credit card's upcoming billing cycle
class CreditCardForecastModel {
  final String accountId;
  final String cardName;
  final int colorValue;
  final int billingDayOfMonth;
  final DateTime nextBillingDate;
  final double currentCycleSpending;
  final double installmentsDueAmount;
  final double recurringChargesAmount;
  final double totalProjectedCharge;
  final int transactionsCount;
  final double previousMonthTotalCharge;

  const CreditCardForecastModel({
    required this.accountId,
    required this.cardName,
    required this.colorValue,
    required this.billingDayOfMonth,
    required this.nextBillingDate,
    required this.currentCycleSpending,
    required this.installmentsDueAmount,
    required this.recurringChargesAmount,
    required this.totalProjectedCharge,
    required this.transactionsCount,
    required this.previousMonthTotalCharge,
  });

  Color get color => Color(colorValue);

  /// Change compared to previous month
  double get differenceFromPreviousMonth => totalProjectedCharge - previousMonthTotalCharge;
  bool get isHigherThanPreviousMonth => differenceFromPreviousMonth > 0;
}
