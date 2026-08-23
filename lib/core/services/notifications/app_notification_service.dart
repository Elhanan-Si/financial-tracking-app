import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../../features/budgets/domain/models/budget_model.dart';
import '../../../features/insights_analytics/domain/models/financial_brief_model.dart';
import '../../../features/insights_analytics/domain/models/spending_classification_model.dart';

final appNotificationServiceProvider = Provider<AppNotificationService>((ref) {
  return AppNotificationService();
});

class AppNotificationService {
  bool isNotificationsEnabled = true;

  void showInAppAlert(
    BuildContext context, {
    required String title,
    required String message,
    bool isWarning = false,
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isWarning ? AppColors.warningDark : AppColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 4),
        content: Row(
          children: [
            Icon(
              isWarning ? AppIcons.alert : AppIcons.infoCircle,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.white)),
                  Text(message, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
        action: actionLabel != null && onAction != null
            ? SnackBarAction(label: actionLabel, textColor: Colors.white, onPressed: onAction)
            : null,
      ),
    );
  }

  void checkAndNotifyBudgetRisks(BuildContext context, List<BudgetProgressModel> budgets) {
    final overBudget = budgets.where((b) => b.isOverBudget).toList();
    if (overBudget.isNotEmpty) {
      showInAppAlert(
        context,
        title: 'חריגת תקציב זוהתה',
        message: 'חריגה ב-${overBudget.first.budget.categoryName ?? "קטגוריה"} (${(overBudget.first.percentageUtilized * 100).toStringAsFixed(0)}% ניצול)',
        isWarning: true,
      );
    }
  }

  void checkAndNotifyWantsLimit(BuildContext context, SpendingClassificationModel spending) {
    if (spending.isWantsExceeded) {
      showInAppAlert(
        context,
        title: 'התרעת הוצאות מותרות (Wants)',
        message: 'הוצאות המותרות החודש הגיעו ל-${spending.wantsPercent.toStringAsFixed(0)}% מההכנסות (מומלץ עד 30%)',
        isWarning: true,
      );
    }
  }

  void notifyMonthlyBriefGenerated(BuildContext context, FinancialBriefModel brief) {
    showInAppAlert(
      context,
      title: 'תקציר פיננסי תקופתי חדש',
      message: brief.headline,
      isWarning: brief.sentiment == BriefSentiment.warning,
    );
  }
}
