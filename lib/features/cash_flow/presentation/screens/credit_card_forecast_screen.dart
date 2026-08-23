import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../controllers/cash_flow_controller.dart';

/// Screen 10: Credit Card Charges Forecast (לוח ריכוז וחיזוי חיובי כרטיסי אשראי)
class CreditCardForecastScreen extends ConsumerWidget {
  const CreditCardForecastScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastsAsync = ref.watch(creditCardForecastsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('חיובי כרטיסי אשראי'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.refresh),
            tooltip: 'רענון נתונים',
            onPressed: () => ref.invalidate(creditCardForecastsProvider),
          ),
        ],
      ),
      body: forecastsAsync.when(
        data: (cards) {
          if (cards.isEmpty) {
            return const Center(
              child: Card(
                margin: EdgeInsets.all(AppSpacing.xl),
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(AppIcons.creditCard, size: 48, color: AppColors.primary),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        'לא נמצאו כרטיסי אשראי פעילים',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        'הוסף כרטיס אשראי במסך החשבונות כדי לחזות חיובי סליקה עתידיים.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final totalProjected = cards.fold<double>(0.0, (sum, c) => sum + c.totalProjectedCharge);

          return ListView(
            padding: AppSpacing.screenPadding,
            children: [
              // Total Projected Credit Card Charges Banner
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2563EB).withAlpha(60),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(AppIcons.creditCard, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'סך חיובי אשראי צפויים במועד הסליקה הקרוב',
                          style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      CurrencyFormatter.formatILS(totalProjected),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'מרוכז מ-${cards.length} כרטיסי אשראי פעילים',
                      style: const TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Individual Card Breakdown
              const Text(
                'פירוט לפי כרטיסי אשראי',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppSpacing.sm),

              Column(
                children: cards.map((card) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Padding(
                      padding: AppSpacing.cardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Card Header
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: card.color.withAlpha(35),
                                child: Icon(AppIcons.creditCard, color: card.color, size: 20),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      card.cardName,
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                                    ),
                                    Text(
                                      'מועד חיוב: ${AppDateFormatter.formatShortDate(card.nextBillingDate)} (ב-${card.billingDayOfMonth} לחודש)',
                                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                CurrencyFormatter.formatILS(card.totalProjectedCharge),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: AppSpacing.lg),

                          // Components Breakdown
                          _buildDetailRow('עסקאות שוטפות במחזור', card.currentCycleSpending),
                          const SizedBox(height: 4),
                          _buildDetailRow('תשלומים עתידיים לחיוב', card.installmentsDueAmount),
                          const SizedBox(height: 4),
                          _buildDetailRow('הוראות קבע ומנויים בכרטיס', card.recurringChargesAmount),

                          if (card.previousMonthTotalCharge > 0) ...[
                            const SizedBox(height: AppSpacing.sm),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('בהשוואה לחודש קודם', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                Text(
                                  card.isHigherThanPreviousMonth
                                      ? '+${CurrencyFormatter.formatILS(card.differenceFromPreviousMonth)} (עלייה)'
                                      : '${CurrencyFormatter.formatILS(card.differenceFromPreviousMonth)} (ירידה)',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: card.isHigherThanPreviousMonth ? AppColors.expense : AppColors.income,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה בטעינת חיובי אשראי: $err')),
      ),
    );
  }

  Widget _buildDetailRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        Text(
          CurrencyFormatter.formatILS(amount),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
