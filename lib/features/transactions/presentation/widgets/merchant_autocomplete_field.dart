import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../categories_tags/domain/models/merchant_model.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';

/// Autocomplete input field for merchants with auto-categorization suggestion
class MerchantAutocompleteField extends ConsumerWidget {
  final TextEditingController controller;
  final ValueChanged<MerchantModel>? onMerchantSelected;

  const MerchantAutocompleteField({
    super.key,
    required this.controller,
    this.onMerchantSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesRepo = ref.watch(categoriesRepositoryProvider);

    return Autocomplete<MerchantModel>(
      initialValue: TextEditingValue(text: controller.text),
      displayStringForOption: (option) => option.name,
      optionsBuilder: (textEditingValue) async {
        if (textEditingValue.text.trim().isEmpty) return const [];
        return await categoriesRepo.searchMerchants(textEditingValue.text);
      },
      onSelected: (option) {
        controller.text = option.name;
        if (onMerchantSelected != null) {
          onMerchantSelected!(option);
        }
      },
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            labelText: 'בית עסק (השלמה אוטומטית)',
            hintText: 'לדוגמה: שופרסל, סונול, וולט...',
            prefixIcon: Icon(AppIcons.merchant),
          ),
          onChanged: (val) {
            controller.text = val;
          },
          onFieldSubmitted: (value) => onFieldSubmitted(),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topRight,
          child: Material(
            elevation: 4,
            borderRadius: AppSpacing.roundedMd,
            color: AppColors.surface,
            child: SizedBox(
              width: 320,
              height: 200,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    dense: true,
                    leading: const Icon(AppIcons.merchant, size: 18, color: AppColors.primary),
                    title: Text(option.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: option.defaultCategoryName != null
                        ? Text('סיווג: ${option.defaultCategoryName}', style: const TextStyle(fontSize: 11, color: AppColors.textMuted))
                        : null,
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
