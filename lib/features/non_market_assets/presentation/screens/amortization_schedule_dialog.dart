import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../data/services/amortization_calculator.dart';
import '../../domain/models/liability_model.dart';

class AmortizationScheduleDialog extends StatelessWidget {
  final LiabilityModel liability;

  const AmortizationScheduleDialog({super.key, required this.liability});

  @override
  Widget build(BuildContext context) {
    final schedule = AmortizationCalculator.generateSpitzerSchedule(
      principal: liability.currentPrincipal > 0 ? liability.currentPrincipal : liability.initialPrincipal,
      annualInterestRatePercent: liability.interestRate,
      totalMonths: liability.remainingPayments > 0 ? liability.remainingPayments : 12,
      startDate: DateTime.now(),
    );

    final totalInterest = AmortizationCalculator.calculateTotalInterestPaid(
      principal: liability.currentPrincipal > 0 ? liability.currentPrincipal : liability.initialPrincipal,
      annualInterestRatePercent: liability.interestRate,
      totalMonths: liability.remainingPayments > 0 ? liability.remainingPayments : 12,
    );

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        padding: AppSpacing.screenPadding,
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(AppIcons.time, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text('לוח סילוקין שפיצר: ${liability.name}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  ],
                ),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: AppSpacing.roundedMd,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryItem('ריבית שנתית', '${liability.interestRate}%'),
                  _buildSummaryItem('תשלומים שנותרו', '${liability.remainingPayments} חודשים'),
                  _buildSummaryItem('סך ריבית צפויה', CurrencyFormatter.formatILS(totalInterest)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Row(
              children: [
                Expanded(flex: 1, child: Text('#', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12))),
                Expanded(flex: 2, child: Text('תאריך', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12))),
                Expanded(flex: 2, child: Text('החזר', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12))),
                Expanded(flex: 2, child: Text('ע"ח קרן', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.income))),
                Expanded(flex: 2, child: Text('ע"ח ריבית', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.expense))),
                Expanded(flex: 2, child: Text('יתרה', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12))),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: schedule.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = schedule[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text('${item.paymentNumber}', style: const TextStyle(fontSize: 11))),
                        Expanded(flex: 2, child: Text(AppDateFormatter.formatShortDate(item.paymentDate), style: const TextStyle(fontSize: 10))),
                        Expanded(flex: 2, child: Text(CurrencyFormatter.formatILS(item.monthlyPayment), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700))),
                        Expanded(flex: 2, child: Text(CurrencyFormatter.formatILS(item.principalComponent), style: const TextStyle(fontSize: 11, color: AppColors.income))),
                        Expanded(flex: 2, child: Text(CurrencyFormatter.formatILS(item.interestComponent), style: const TextStyle(fontSize: 11, color: AppColors.expense))),
                        Expanded(flex: 2, child: Text(CurrencyFormatter.formatILS(item.remainingBalance), style: const TextStyle(fontSize: 11))),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
      ],
    );
  }
}
