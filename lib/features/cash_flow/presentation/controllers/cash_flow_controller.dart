import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../data/repositories/cash_flow_repository_impl.dart';
import '../../domain/models/cash_flow_model.dart';
import '../../domain/models/credit_card_forecast_model.dart';
import '../../domain/repositories/cash_flow_repository.dart';

final cashFlowDaysHorizonProvider = StateProvider<int>((ref) => 30);

class WhatIfScenariosNotifier extends StateNotifier<List<WhatIfScenarioModel>> {
  WhatIfScenariosNotifier() : super([]);

  void addScenario(WhatIfScenarioModel scenario) {
    state = [...state, scenario];
  }

  void updateScenario(WhatIfScenarioModel updated) {
    state = [
      for (final s in state)
        if (s.id == updated.id) updated else s,
    ];
  }

  void toggleScenario(String id) {
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(isEnabled: !s.isEnabled) else s,
    ];
  }

  void removeScenario(String id) {
    state = state.where((s) => s.id != id).toList();
  }
}

final whatIfScenariosProvider = StateNotifierProvider<WhatIfScenariosNotifier, List<WhatIfScenarioModel>>((ref) {
  return WhatIfScenariosNotifier();
});

final cashFlowRepositoryProvider = Provider<CashFlowRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return CashFlowRepositoryImpl(db);
});

final creditCardForecastsProvider = FutureProvider<List<CreditCardForecastModel>>((ref) async {
  final repo = ref.watch(cashFlowRepositoryProvider);
  return await repo.getCreditCardForecasts();
});

final cashFlowForecastProvider = FutureProvider<CashFlowForecastSummary>((ref) async {
  final repo = ref.watch(cashFlowRepositoryProvider);
  final days = ref.watch(cashFlowDaysHorizonProvider);
  final scenarios = ref.watch(whatIfScenariosProvider);

  return await repo.calculateCashFlowForecast(
    days: days,
    whatIfScenarios: scenarios,
  );
});
