import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';

/// Reusable widget to pick an icon and color without emojis
class IconColorPicker extends StatelessWidget {
  final int selectedColor;
  final String selectedIcon;
  final ValueChanged<int> onColorSelected;
  final ValueChanged<String> onIconSelected;

  const IconColorPicker({
    super.key,
    required this.selectedColor,
    required this.selectedIcon,
    required this.onColorSelected,
    required this.onIconSelected,
  });

  static const List<Map<String, dynamic>> _iconList = [
    {'name': 'housing', 'icon': AppIcons.housing, 'label': 'דיור'},
    {'name': 'rent', 'icon': AppIcons.rent, 'label': 'שכירות'},
    {'name': 'utilities', 'icon': AppIcons.utilities, 'label': 'חשמל/מים'},
    {'name': 'foodDining', 'icon': AppIcons.foodDining, 'label': 'מסעדות'},
    {'name': 'groceries', 'icon': AppIcons.groceries, 'label': 'סופר'},
    {'name': 'transportation', 'icon': AppIcons.transportation, 'label': 'רכב'},
    {'name': 'publicTransit', 'icon': AppIcons.publicTransit, 'label': 'תחבורה ציבורית'},
    {'name': 'gas', 'icon': AppIcons.gas, 'label': 'דלק'},
    {'name': 'shopping', 'icon': AppIcons.shopping, 'label': 'קניות'},
    {'name': 'electronics', 'icon': AppIcons.electronics, 'label': 'חשמל/מחשב'},
    {'name': 'entertainment', 'icon': AppIcons.entertainment, 'label': 'בילויים'},
    {'name': 'travel', 'icon': AppIcons.travel, 'label': 'חופשות'},
    {'name': 'healthcare', 'icon': AppIcons.healthcare, 'label': 'בריאות'},
    {'name': 'fitness', 'icon': AppIcons.fitness, 'label': 'כושר'},
    {'name': 'education', 'icon': AppIcons.education, 'label': 'חינוך'},
    {'name': 'kids', 'icon': AppIcons.kids, 'label': 'ילדים'},
    {'name': 'pets', 'icon': AppIcons.pets, 'label': 'חיות מחמד'},
    {'name': 'salary', 'icon': AppIcons.salary, 'label': 'שכר'},
    {'name': 'gift', 'icon': AppIcons.gift, 'label': 'מתנה'},
    {'name': 'stock', 'icon': AppIcons.stock, 'label': 'השקעות'},
    {'name': 'realEstate', 'icon': AppIcons.realEstate, 'label': 'נדל"ן'},
    {'name': 'taxes', 'icon': AppIcons.taxes, 'label': 'מיסים'},
    {'name': 'charity', 'icon': AppIcons.charity, 'label': 'תרומות'},
    {'name': 'bank', 'icon': AppIcons.bank, 'label': 'בנק'},
    {'name': 'creditCard', 'icon': AppIcons.creditCard, 'label': 'כרטיס'},
    {'name': 'wallet', 'icon': AppIcons.wallet, 'label': 'ארנק'},
    {'name': 'cash', 'icon': AppIcons.cash, 'label': 'מזומן'},
    {'name': 'business', 'icon': AppIcons.business, 'label': 'עסקים'},
    {'name': 'uncategorized', 'icon': AppIcons.uncategorized, 'label': 'שונות'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Color Picker Row
        const Text('צבע זיהוי', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        const SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: AppColors.categoryPalette.map((color) {
              final isSelected = color.toARGB32() == selectedColor;
              return Padding(
                padding: const EdgeInsets.only(left: AppSpacing.sm),
                child: GestureDetector(
                  onTap: () => onColorSelected(color.toARGB32()),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.textPrimary : Colors.transparent,
                        width: 2.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.5),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: isSelected
                        ? const Center(
                            child: Icon(AppIcons.check, color: Colors.white, size: 18),
                          )
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Icon Wrap Grid
        const Text('אייקון ייצוגי', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _iconList.map((item) {
            final iconName = item['name'] as String;
            final iconData = item['icon'] as IconData;
            final isSelected = iconName == selectedIcon;

            return InkWell(
              onTap: () => onIconSelected(iconName),
              borderRadius: AppSpacing.roundedSm,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected ? Color(selectedColor).withValues(alpha: 0.15) : AppColors.surfaceVariant,
                  borderRadius: AppSpacing.roundedSm,
                  border: Border.all(
                    color: isSelected ? Color(selectedColor) : AppColors.border,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Icon(
                    iconData,
                    size: 20,
                    color: isSelected ? Color(selectedColor) : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
