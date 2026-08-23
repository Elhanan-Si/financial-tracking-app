import 'package:financial_tracking/features/insights_analytics/data/services/financial_brief_generator.dart';
import 'package:financial_tracking/features/insights_analytics/domain/models/comparative_analytics_model.dart';
import 'package:financial_tracking/features/insights_analytics/domain/models/financial_brief_model.dart';
import 'package:financial_tracking/features/insights_analytics/domain/models/savings_rate_model.dart';
import 'package:financial_tracking/features/insights_analytics/domain/models/spending_classification_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TASK-30: Financial Brief Generator Tests', () {
    test('Generates positive Hebrew summary when expenses decrease and savings rate is high', () {
      final spending = const SpendingClassificationModel(
        totalIncome: 20000.0,
        totalExpenses: 12000.0,
        needsAmount: 7000.0,
        wantsAmount: 3000.0,
        savingsAmount: 8000.0,
        fixedAmount: 6000.0,
        variableAmount: 6000.0,
      );

      final comparative = const ComparativeAnalyticsModel(
        currentPeriodLabel: '8/2026',
        previousPeriodLabel: '7/2026',
        currentTotalExpenses: 12000.0,
        previousTotalExpenses: 15000.0, // Expenses fell by 20%
        currentTotalIncome: 20000.0,
        previousTotalIncome: 20000.0,
        topIncreasingCategories: [],
        topDecreasingCategories: [
          CategoryMover(
            categoryId: 'cat_dining',
            categoryName: 'מסעדות',
            currentAmount: 1000.0,
            previousAmount: 3000.0,
            deltaAmount: -2000.0,
            deltaPercent: -66.6,
          ),
        ],
      );

      final savings = const SavingsRateModel(
        currentMonthIncome: 20000.0,
        currentMonthExpenses: 12000.0,
        currentMonthSavingsRate: 40.0,
        threeMonthMovingAverage: 35.0,
        sixMonthMovingAverage: 30.0,
        twelveMonthMovingAverage: 28.0,
        monthlyBurnRate: 13000.0,
      );

      final brief = FinancialBriefGenerator.generate(
        spending: spending,
        comparative: comparative,
        savings: savings,
      );

      expect(brief.sentiment, BriefSentiment.positive);
      expect(brief.headline.contains('פחות מחודש שעבר'), true);
      expect(brief.bulletPoints.isNotEmpty, true);
    });

    test('Generates warning Hebrew summary when wants exceed limit or budgets are at risk', () {
      final spending = const SpendingClassificationModel(
        totalIncome: 10000.0,
        totalExpenses: 9000.0,
        needsAmount: 4000.0,
        wantsAmount: 5000.0, // 50% wants > 30%
        savingsAmount: 1000.0,
        fixedAmount: 3000.0,
        variableAmount: 6000.0,
      );

      final comparative = const ComparativeAnalyticsModel(
        currentPeriodLabel: '8/2026',
        previousPeriodLabel: '7/2026',
        currentTotalExpenses: 9000.0,
        previousTotalExpenses: 7000.0, // Expenses increased by ~28%
        currentTotalIncome: 10000.0,
        previousTotalIncome: 10000.0,
        topIncreasingCategories: [
          CategoryMover(
            categoryId: 'cat_shop',
            categoryName: 'קניות ואופנה',
            currentAmount: 4000.0,
            previousAmount: 1500.0,
            deltaAmount: 2500.0,
            deltaPercent: 166.0,
          ),
        ],
        topDecreasingCategories: [],
      );

      final savings = const SavingsRateModel(
        currentMonthIncome: 10000.0,
        currentMonthExpenses: 9000.0,
        currentMonthSavingsRate: 10.0,
        threeMonthMovingAverage: 20.0,
        sixMonthMovingAverage: 20.0,
        twelveMonthMovingAverage: 20.0,
        monthlyBurnRate: 8500.0,
      );

      final brief = FinancialBriefGenerator.generate(
        spending: spending,
        comparative: comparative,
        savings: savings,
        budgetsAtRiskCount: 2,
      );

      expect(brief.sentiment, BriefSentiment.warning);
      expect(brief.headline.contains('עלו'), true);
      expect(brief.bulletPoints.any((b) => b.contains('תקציבים')), true);
    });
  });
}
