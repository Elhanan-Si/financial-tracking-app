import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/backup_settings/presentation/controllers/help_settings_controller.dart';
import '../constants/app_colors.dart';
import '../constants/app_icons.dart';
import '../constants/app_spacing.dart';

/// Reusable Financial Info Button that shows a friendly Hebrew explanation bottom sheet
class FinancialInfoTooltip extends ConsumerWidget {
  final String title;
  final String explanation;
  final String? formula;
  final String? practicalTip;

  const FinancialInfoTooltip({
    super.key,
    required this.title,
    required this.explanation,
    this.formula,
    this.practicalTip,
  });

  void _showHelpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.md,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pinned Header
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.primaryLight,
                      radius: 18,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Icon(AppIcons.help, color: AppColors.primary, size: 20),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(AppIcons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(height: AppSpacing.md),

                // Scrollable Body for Long Text & Formulas
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          explanation,
                          style: const TextStyle(fontSize: 14, height: 1.5, color: AppColors.textPrimary),
                        ),
                        if (formula != null) ...[
                          const SizedBox(height: AppSpacing.md),
                          Container(
                            width: double.infinity,
                            padding: AppSpacing.cardPadding,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: AppSpacing.roundedSm,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('נוסחת החישוב:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.textSecondary)),
                                const SizedBox(height: 4),
                                Text(formula!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary)),
                              ],
                            ),
                          ),
                        ],
                        if (practicalTip != null) ...[
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(AppIcons.infoCircle, size: 16, color: AppColors.secondary),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  practicalTip!,
                                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: AppSpacing.sm),
                      ],
                    ),
                  ),
                ),

                // Pinned Footer Button
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('הבנתי, תודה'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(helpTooltipsEnabledProvider);
    if (!isEnabled) {
      return const SizedBox.shrink();
    }

    return InkWell(
      onTap: () => _showHelpSheet(context),
      borderRadius: BorderRadius.circular(12),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Icon(
            AppIcons.help,
            size: 16,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
