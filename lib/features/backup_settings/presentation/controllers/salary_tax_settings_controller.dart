import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/salary_tax_settings_service.dart';

final salaryTaxSettingsServiceProvider = Provider<SalaryTaxSettingsService>((ref) {
  return SalaryTaxSettingsService();
});

class SalaryTaxSettingsNotifier extends StateNotifier<SalaryTaxSettingsModel> {
  final SalaryTaxSettingsService _service;

  SalaryTaxSettingsNotifier(this._service) : super(const SalaryTaxSettingsModel()) {
    _load();
  }

  Future<void> _load() async {
    final settings = await _service.loadSettings();
    state = settings;
  }

  Future<void> updateSettings({
    double? baseSalary,
    double? defaultTaxRate,
  }) async {
    final updated = state.copyWith(
      baseSalary: baseSalary,
      defaultTaxRate: defaultTaxRate,
    );
    state = updated;
    await _service.saveSettings(updated);
  }
}

final salaryTaxSettingsProvider = StateNotifierProvider<SalaryTaxSettingsNotifier, SalaryTaxSettingsModel>((ref) {
  final service = ref.watch(salaryTaxSettingsServiceProvider);
  return SalaryTaxSettingsNotifier(service);
});
