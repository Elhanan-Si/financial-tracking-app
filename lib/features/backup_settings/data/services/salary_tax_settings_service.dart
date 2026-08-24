import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SalaryTaxSettingsModel {
  final double baseSalary;
  final double defaultTaxRate; // in percentage e.g. 20.0 for 20%

  const SalaryTaxSettingsModel({
    this.baseSalary = 18000.0,
    this.defaultTaxRate = 20.0,
  });

  /// Computes tax amount and net income from gross amount
  ({double gross, double net, double tax}) calculateFromGross(double gross) {
    final tax = gross * (defaultTaxRate / 100.0);
    final net = gross - tax;
    return (gross: gross, net: net, tax: tax);
  }

  /// Computes gross amount and tax amount from net income
  ({double gross, double net, double tax}) calculateFromNet(double net) {
    if (defaultTaxRate >= 100) return (gross: net, net: net, tax: 0.0);
    final gross = net / (1.0 - (defaultTaxRate / 100.0));
    final tax = gross - net;
    return (gross: gross, net: net, tax: tax);
  }

  Map<String, dynamic> toJson() => {
        'baseSalary': baseSalary,
        'defaultTaxRate': defaultTaxRate,
      };

  factory SalaryTaxSettingsModel.fromJson(Map<String, dynamic> json) {
    return SalaryTaxSettingsModel(
      baseSalary: (json['baseSalary'] as num?)?.toDouble() ?? 18000.0,
      defaultTaxRate: (json['defaultTaxRate'] as num?)?.toDouble() ?? 20.0,
    );
  }

  SalaryTaxSettingsModel copyWith({
    double? baseSalary,
    double? defaultTaxRate,
  }) {
    return SalaryTaxSettingsModel(
      baseSalary: baseSalary ?? this.baseSalary,
      defaultTaxRate: defaultTaxRate ?? this.defaultTaxRate,
    );
  }
}

class SalaryTaxSettingsService {
  final FlutterSecureStorage _storage;
  static const String _keySalaryTaxSettings = 'app_salary_tax_settings_v1';

  SalaryTaxSettingsService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              wOptions: WindowsOptions(useBackwardCompatibility: false),
            );

  Future<SalaryTaxSettingsModel> loadSettings() async {
    try {
      final raw = await _storage.read(key: _keySalaryTaxSettings);
      if (raw != null && raw.isNotEmpty) {
        final json = jsonDecode(raw) as Map<String, dynamic>;
        return SalaryTaxSettingsModel.fromJson(json);
      }
    } catch (_) {}
    return const SalaryTaxSettingsModel();
  }

  Future<void> saveSettings(SalaryTaxSettingsModel settings) async {
    final raw = jsonEncode(settings.toJson());
    await _storage.write(key: _keySalaryTaxSettings, value: raw);
  }
}
