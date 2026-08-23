import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/models/category_model.dart';
import 'icon_color_picker.dart';

/// BottomSheet to create or edit a category
class CategoryEditDialog extends StatefulWidget {
  final CategoryModel? existingCategory;
  final String? initialParentId;
  final String initialType;
  final List<CategoryModel> availableParents;
  final Future<void> Function(CategoryModel category) onSave;

  const CategoryEditDialog({
    super.key,
    this.existingCategory,
    this.initialParentId,
    this.initialType = 'expense',
    required this.availableParents,
    required this.onSave,
  });

  static Future<void> show({
    required BuildContext context,
    CategoryModel? existingCategory,
    String? initialParentId,
    String initialType = 'expense',
    required List<CategoryModel> availableParents,
    required Future<void> Function(CategoryModel category) onSave,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => CategoryEditDialog(
        existingCategory: existingCategory,
        initialParentId: initialParentId,
        initialType: initialType,
        availableParents: availableParents,
        onSave: onSave,
      ),
    );
  }

  @override
  State<CategoryEditDialog> createState() => _CategoryEditDialogState();
}

class _CategoryEditDialogState extends State<CategoryEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late String _type;
  late String? _parentId;
  late SpendingClassification _classification;
  late CategoryFlexibility _flexibility;
  late int _colorValue;
  late String _iconName;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final cat = widget.existingCategory;
    _nameController = TextEditingController(text: cat?.name ?? '');
    _type = cat?.type ?? widget.initialType;
    _parentId = cat?.parentId ?? widget.initialParentId;
    _classification = cat?.spendingClassification ?? SpendingClassification.needs;
    _flexibility = cat?.flexibility ?? CategoryFlexibility.variable;
    _colorValue = cat?.colorValue ?? 0xFF3B82F6;
    _iconName = cat?.iconName ?? 'uncategorized';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final category = CategoryModel(
      id: widget.existingCategory?.id ?? '',
      parentId: _parentId,
      name: _nameController.text.trim(),
      type: _type,
      spendingClassification: _classification,
      flexibility: _flexibility,
      colorValue: _colorValue,
      iconName: _iconName,
      isDefault: widget.existingCategory?.isDefault ?? false,
      createdAt: widget.existingCategory?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await widget.onSave(category);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בשמירת קטגוריה: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.existingCategory == null;
    final title = isNew ? (_parentId == null ? 'הוספת קטגוריית אב' : 'הוספת תת-קטגוריה') : 'עריכת קטגוריה';

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
        top: AppSpacing.md,
        left: AppSpacing.lg,
        right: AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(_colorValue).withValues(alpha: 0.15),
                        child: Icon(AppIcons.fromString(_iconName), color: Color(_colorValue), size: 20),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(AppIcons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Type Selector (Expense / Income)
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'expense', label: Text('הוצאה')),
                  ButtonSegment(value: 'income', label: Text('הכנסה')),
                ],
                selected: {_type},
                onSelectionChanged: (set) {
                  final newType = set.first;
                  setState(() {
                    _type = newType;
                    if (_parentId != null &&
                        !widget.availableParents.any((p) => p.id == _parentId && p.type == newType)) {
                      _parentId = null;
                    }
                  });
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // Category Name Input
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'שם הקטגוריה',
                  hintText: 'לדוגמה: מסעדות ובתי קפה',
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'אנא הזן שם קטגוריה';
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // Parent Category Dropdown (if creating subcategory or editing)
              Builder(
                builder: (context) {
                  final matchingParents = widget.availableParents
                      .where((p) => p.id != widget.existingCategory?.id && p.type == _type)
                      .toList();
                  final safeParentValue = matchingParents.any((p) => p.id == _parentId) ? _parentId : null;

                  return Column(
                    children: [
                      DropdownButtonFormField<String?>(
                        value: safeParentValue,
                        isDense: true,
                        isExpanded: true,
                        style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                        decoration: const InputDecoration(
                          labelText: 'קטגוריית אב (אופציונלי)',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                        items: [
                          const DropdownMenuItem(value: null, child: Text('ללא קטגוריית אב (קטגוריה ראשית)', style: TextStyle(fontSize: 13))),
                          ...matchingParents.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name, style: const TextStyle(fontSize: 13)))),
                        ],
                        onChanged: (val) => setState(() => _parentId = val),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                  );
                },
              ),

              // Classification (Needs / Wants) - relevant for Expense categories only
              if (_type == 'expense') ...[
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<SpendingClassification>(
                        value: _classification,
                        isDense: true,
                        isExpanded: true,
                        style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                        decoration: const InputDecoration(
                          labelText: 'סיווג הוצאה',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                        items: SpendingClassification.values
                            .map((c) => DropdownMenuItem(value: c, child: Text(c.label, style: const TextStyle(fontSize: 13))))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _classification = val);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: DropdownButtonFormField<CategoryFlexibility>(
                        value: _flexibility,
                        isDense: true,
                        isExpanded: true,
                        style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                        decoration: const InputDecoration(
                          labelText: 'גמישות',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                        items: CategoryFlexibility.values
                            .map((f) => DropdownMenuItem(value: f, child: Text(f.label, style: const TextStyle(fontSize: 13))))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _flexibility = val);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Icon & Color Picker
              IconColorPicker(
                selectedColor: _colorValue,
                selectedIcon: _iconName,
                onColorSelected: (col) => setState(() => _colorValue = col),
                onIconSelected: (ico) => setState(() => _iconName = ico),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Submit Button
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('שמור קטגוריה', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
