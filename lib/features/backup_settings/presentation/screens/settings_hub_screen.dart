import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../controllers/help_settings_controller.dart';
import 'backup_restore_screen.dart';

/// Screen 20, 21, 22 Hub: Settings & Preferences (מרכז הגדרות והתאמה אישית)
class SettingsHubScreen extends ConsumerWidget {
  const SettingsHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('הגדרות'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          _buildSettingsTile(
            icon: AppIcons.bank,
            title: 'חשבונות ואמצעי תשלום',
            subtitle: 'ניהול חשבונות בנק, כרטיסי אשראי ויתרות',
            onTap: () => context.push('${AppRoutes.settings}/accounts'),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingsTile(
            icon: AppIcons.transfer,
            title: 'העברות פנימיות בין חשבונות',
            subtitle: 'ביצוע העברה בין שני חשבונות, המרת מטבעות והיסטוריה',
            onTap: () => context.push(AppRoutes.transfers),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingsTile(
            icon: AppIcons.recurring,
            title: 'הוראות קבע ומנויים מחזוריים',
            subtitle: 'ניהול מנויים, שכירות, חיובים קבועים ובדיקת התחייבויות',
            onTap: () => context.push(AppRoutes.recurring),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingsTile(
            icon: AppIcons.uncategorized,
            title: 'עץ קטגוריות, תגיות ובתי עסק',
            subtitle: 'התאמה אישית של קטגוריות הוצאה, הכנסה ומיזוג בתי עסק',
            onTap: () => context.push('${AppRoutes.settings}/categories'),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingsTile(
            icon: AppIcons.netWorth,
            title: 'עסקאות לסיווג והצעות חכמות',
            subtitle: 'אישור מרוכז של קטגוריות לתנועות ללא סיווג',
            onTap: () => context.push(AppRoutes.uncategorizedTransactions),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingsTile(
            icon: AppIcons.uncategorized,
            title: 'כללי סיווג אוטומטיים',
            subtitle: 'הגדרת חוקים ודפוסים לזיהוי קטגוריות מתקדם',
            onTap: () => context.push(AppRoutes.categoryRules),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingsTile(
            icon: AppIcons.security,
            title: 'אבטחה, נעילה וביומטרי',
            subtitle: 'ניהול קוד PIN, טביעת אצבע וזמני נעילה אוטומטית',
            onTap: () => context.push(AppRoutes.securitySettings),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingsTile(
            icon: AppIcons.importData,
            title: 'ייבוא דוחות בנק וכרטיסי אשראי',
            subtitle: 'טעינת קובצי אקסל/CSV מלאומי, ישראכרט, פאג"י, OneZero',
            onTap: () => context.push(AppRoutes.importData),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingsTile(
            icon: AppIcons.backup,
            title: 'גיבוי, שחזור ואיפוס נתונים',
            subtitle: 'ייצוא קובץ גיבוי מוצפן JSON / Excel, שחזור ואיפוס מאובטח',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BackupRestoreScreen()),
              );
            },
          ),
          const SizedBox(height: AppSpacing.md),

          // Help Tooltips Visibility Setting Card
          Card(
            child: SwitchListTile(
              secondary: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryLight,
                child: const Directionality(
                  textDirection: TextDirection.ltr,
                  child: Icon(AppIcons.help, color: AppColors.primary, size: 20),
                ),
              ),
              title: const Text('כלי עזר והסברים (סימני שאלה)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              subtitle: const Text(
                'הצגת סימני שאלה עם הסברים פיננסיים ונוסחאות חישוב במסכי האפליקציה',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              value: ref.watch(helpTooltipsEnabledProvider),
              onChanged: (val) => ref.read(helpTooltipsEnabledProvider.notifier).setEnabled(val),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Divider(),
          const SizedBox(height: AppSpacing.md),
          const Center(
            child: Text(
              'גרסה 2.7.0 • Offline-First מוצפן',
              style: TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        trailing: const Icon(AppIcons.chevronEnd, size: 18, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }
}
