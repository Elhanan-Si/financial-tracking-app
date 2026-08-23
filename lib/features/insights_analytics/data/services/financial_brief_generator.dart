import '../../../../core/utils/currency_formatter.dart';
import '../../domain/models/comparative_analytics_model.dart';
import '../../domain/models/financial_brief_model.dart';
import '../../domain/models/savings_rate_model.dart';
import '../../domain/models/spending_classification_model.dart';

class FinancialBriefGenerator {
  static FinancialBriefModel generate({
    required SpendingClassificationModel spending,
    required ComparativeAnalyticsModel comparative,
    required SavingsRateModel savings,
    int budgetsAtRiskCount = 0,
  }) {
    final bullets = <String>[];
    String headline = 'תמונת המצב הפיננסית החודשית שלך יציבה';
    BriefSentiment sentiment = BriefSentiment.neutral;

    // 1. Evaluate Net Savings & Comparison
    if (comparative.previousTotalExpenses > 0) {
      final expDelta = comparative.expensesDeltaPercent;
      if (expDelta <= -5.0) {
        headline =
            'מצוין! החודש הוצאת ${expDelta.abs().toStringAsFixed(0)}% פחות מחודש שעבר';
        sentiment = BriefSentiment.positive;
      } else if (expDelta >= 10.0) {
        headline =
            'שים לב: ההוצאות החודש עלו ב-${expDelta.toStringAsFixed(0)}% לעומת חודש שעבר';
        sentiment = BriefSentiment.warning;
      }
    } else if (savings.currentMonthSavingsRate >= 20.0) {
      headline =
          'קצב מצוין! שיעור החיסכון שלך החודש עומד על ${savings.currentMonthSavingsRate.toStringAsFixed(0)}%';
      sentiment = BriefSentiment.positive;
    }

    // 2. Savings Rate & Net
    if (savings.currentMonthIncome > 0) {
      final net = savings.currentMonthNetSavings;
      if (net >= 0) {
        bullets.add(
          'חיסכון נקי החודש: ${CurrencyFormatter.formatILS(net)} (${savings.currentMonthSavingsRate.toStringAsFixed(0)}% מההכנסות)',
        );
      } else {
        bullets.add(
          'גירעון חודשי נוכחי: ${CurrencyFormatter.formatILS(net.abs())} מעבר להכנסות',
        );
      }
    }

    // 3. 50/30/20 Rule Check
    if (spending.totalExpenses > 0) {
      if (spending.isWantsExceeded) {
        bullets.add(
          'הוצאות מותרות (Wants) הגיעו ל-${spending.wantsPercent.toStringAsFixed(0)}% מההכנסות (המלצת 50/30/20: עד 30%)',
        );
      } else {
        bullets.add(
          'פילוח הוצאות: ${spending.needsPercent.toStringAsFixed(0)}% צרכים בסיסיים, ${spending.wantsPercent.toStringAsFixed(0)}% מותרות',
        );
      }
    }

    // 4. Top Mover highlight
    if (comparative.topIncreasingCategories.isNotEmpty) {
      final topInc = comparative.topIncreasingCategories.first;
      if (topInc.deltaAmount > 200) {
        bullets.add(
          'העלייה הבולטת ביותר: ${topInc.categoryName} (+${CurrencyFormatter.formatILS(topInc.deltaAmount)})',
        );
      }
    } else if (comparative.topDecreasingCategories.isNotEmpty) {
      final topDec = comparative.topDecreasingCategories.first;
      if (topDec.deltaAmount < -200) {
        bullets.add(
          'החיסכון הגדול ביותר: ${topDec.categoryName} (${CurrencyFormatter.formatILS(topDec.deltaAmount.abs())}-)',
        );
      }
    }

    // 5. Budgets warning
    if (budgetsAtRiskCount > 0) {
      bullets.add(
        'ישנם $budgetsAtRiskCount תקציבים קרובים למיצוי או בחריגה החודש',
      );
      if (sentiment != BriefSentiment.positive) {
        sentiment = BriefSentiment.warning;
      }
    }

    if (bullets.isEmpty) {
      bullets.add('המשך להזין תנועות לקבלת ניתוח מגמות ותובנות עמוקות');
    }

    return FinancialBriefModel(
      headline: headline,
      bulletPoints: bullets,
      sentiment: sentiment,
      generatedAt: DateTime.now(),
    );
  }
}
