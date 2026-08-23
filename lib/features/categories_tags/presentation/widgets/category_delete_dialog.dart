import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/models/category_model.dart';

/// Dialog to confirm category deletion and choose replacement category for historical transactions
class CategoryDeleteDialog extends StatefulWidget {
  final CategoryModel category;
  final List<CategoryModel> otherCategories;
  final Future<void> Function(String? replacementCategoryId) onConfirmDelete;

  const CategoryDeleteDialog({
    super.key,
    required this.category,
    required this.otherCategories,
    required this.onConfirmDelete,
  });

  @override
  State<CategoryDeleteDialog> createState() => _CategoryDeleteDialogState();
}

class _CategoryDeleteDialogState extends State<CategoryDeleteDialog> {
  String? _replacementCategoryId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final candidates = widget.otherCategories.where((c) => c.id != widget.category.id && c.type == widget.category.type).toList();
    if (candidates.isNotEmpty) {
      _replacementCategoryId = candidates.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final candidates = widget.otherCategories.where((c) => c.id != widget.category.id && c.type == widget.category.type).toList();

    return AlertDialog(
      title: const Row(
        children: [
          Icon(AppIcons.delete, color: AppColors.error),
          SizedBox(width: AppSpacing.sm),
          Text('מחיקת קטגוריה'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'האם אתה בטוח שברצונך למחוק את הקטגוריה "${widget.category.name}"?',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'כדי לשמור על שלמות הדוחות הפיננסיים, בחר קטגוריה חלופית שאליה יועברו כלל העסקאות ההיסטוריות:',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),
          if (candidates.isNotEmpty) ...[
            DropdownButtonFormField<String>(
              value: _replacementCategoryId,
              decoration: const InputDecoration(labelText: 'קטגוריה חלופית'),
              items: candidates.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
              onChanged: (val) => setState(() => _replacementCategoryId = val),
            ),
          ] else ...[
            const Text(
              'אין קטגוריות חלופיות זמינות. תנועות קיימות יועברו ללא סיווג.',
              style: TextStyle(fontSize: 12, color: AppColors.warning),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('ביטול'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
          onPressed: _isLoading
              ? null
              : () async {
                  setState(() => _isLoading = true);
                  try {
                    await widget.onConfirmDelete(_replacementCategoryId);
                    if (context.mounted) Navigator.pop(context);
                  } finally {
                    if (mounted) setState(() => _isLoading = false);
                  }
                },
          child: _isLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Text('מחק והעבר תנועות'),
        ),
      ],
    );
  }
}
