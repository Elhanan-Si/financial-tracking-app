import 'dart:math';
import '../../domain/models/amortization_schedule_model.dart';

/// Loan Amortization Calculator (Spitzer / Equal Principal)
class AmortizationCalculator {
  /// Calculates monthly payment under the Spitzer formula (לוח שפיצר)
  static double calculateSpitzerMonthlyPayment({
    required double principal,
    required double annualInterestRatePercent,
    required int totalMonths,
  }) {
    if (principal <= 0 || totalMonths <= 0) return 0.0;
    if (annualInterestRatePercent <= 0) return principal / totalMonths;

    final r = (annualInterestRatePercent / 100.0) / 12.0;
    final factor = pow(1.0 + r, totalMonths);
    final monthlyPayment = principal * (r * factor) / (factor - 1.0);
    return monthlyPayment;
  }

  /// Generates full month-by-month Spitzer amortization schedule (לוח סילוקין שפיצר)
  static List<AmortizationScheduleItem> generateSpitzerSchedule({
    required double principal,
    required double annualInterestRatePercent,
    required int totalMonths,
    required DateTime startDate,
  }) {
    final schedule = <AmortizationScheduleItem>[];
    if (principal <= 0 || totalMonths <= 0) return schedule;

    final monthlyPayment = calculateSpitzerMonthlyPayment(
      principal: principal,
      annualInterestRatePercent: annualInterestRatePercent,
      totalMonths: totalMonths,
    );

    final r = (annualInterestRatePercent / 100.0) / 12.0;
    double currentBalance = principal;

    for (int month = 1; month <= totalMonths; month++) {
      final interest = currentBalance * r;
      double principalComponent = monthlyPayment - interest;
      currentBalance -= principalComponent;

      // Adjust last payment rounding
      if (month == totalMonths || currentBalance < 0.01) {
        if (currentBalance != 0.0) {
          principalComponent += currentBalance;
          currentBalance = 0.0;
        }
      }

      final paymentDate = DateTime(startDate.year, startDate.month + (month - 1), startDate.day);

      schedule.add(
        AmortizationScheduleItem(
          paymentNumber: month,
          paymentDate: paymentDate,
          monthlyPayment: monthlyPayment,
          principalComponent: principalComponent,
          interestComponent: interest,
          remainingBalance: currentBalance > 0 ? currentBalance : 0.0,
        ),
      );
    }

    return schedule;
  }

  /// Calculates total interest paid over the life of a loan
  static double calculateTotalInterestPaid({
    required double principal,
    required double annualInterestRatePercent,
    required int totalMonths,
  }) {
    final monthlyPayment = calculateSpitzerMonthlyPayment(
      principal: principal,
      annualInterestRatePercent: annualInterestRatePercent,
      totalMonths: totalMonths,
    );
    final totalPaid = monthlyPayment * totalMonths;
    return max(0.0, totalPaid - principal);
  }
}
