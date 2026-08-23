import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/models/category_model.dart';

/// Modal Bottom Sheet for Searching and Selecting Categories
class CategorySearchPicker {
  static Future<CategoryModel?> show({
    required BuildContext context,
    required List<CategoryModel> categories,
    String? selectedCategoryId,
    String title = 'בחירת קטגוריה',
  }) {
    return showModalBottomSheet<CategoryModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => _CategorySearchSheet(
        categories: categories,
        selectedCategoryId: selectedCategoryId,
        title: title,
      ),
    );
  }
}

class _CategorySearchSheet extends StatefulWidget {
  final List<CategoryModel> categories;
  final String? selectedCategoryId;
  final String title;

  const _CategorySearchSheet({
    required this.categories,
    this.selectedCategoryId,
    required this.title,
  });

  @override
  State<_CategorySearchSheet> createState() => _CategorySearchSheetState();
}

class _CategorySearchSheetState extends State<_CategorySearchSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.categories.where((c) {
      if (_query.isEmpty) return true;
      final nameMatches = c.name.toLowerCase().contains(_query.toLowerCase());
      final isWants = c.isWants && 'מותרות'.contains(_query);
      final isNeeds = c.isNeeds && 'צרכים'.contains(_query);
      return nameMatches || isWants || isNeeds;
    }).toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
          top: AppSpacing.md,
          left: AppSpacing.lg,
          right: AppSpacing.lg,
        ),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                IconButton(
                  icon: const Icon(AppIcons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Search Field
            TextField(
              controller: _searchController,
              autofocus: false,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'חיפוש קטגוריה (לדוגמה: מזון, מותרות, רכב)...',
                prefixIcon: const Icon(AppIcons.search, size: 20),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(AppIcons.close, size: 16),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _query = val.trim()),
            ),
            const SizedBox(height: AppSpacing.md),

            // Category List
            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: Text('לא נמצאו קטגוריות מתאימות לחיפוש', style: TextStyle(color: AppColors.textMuted)),
                    )
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final cat = filtered[index];
                        final isSelected = cat.id == widget.selectedCategoryId;

                        return Card(
                          margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                          color: isSelected ? AppColors.primaryLight.withValues(alpha: 0.5) : AppColors.surface,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Color(cat.colorValue).withValues(alpha: 0.15),
                              child: Icon(cat.icon, color: Color(cat.colorValue), size: 18),
                            ),
                            title: Text(
                              cat.name,
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                fontSize: 14,
                                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: cat.isNeeds ? AppColors.primaryLight : AppColors.warningLight,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    cat.isNeeds ? 'צרכים בסיסיים' : 'מותרות ופנאי',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: cat.isNeeds ? AppColors.primary : AppColors.warning,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: isSelected ? const Icon(AppIcons.check, color: AppColors.primary) : null,
                            onTap: () => Navigator.pop(context, cat),
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
}
