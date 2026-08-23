/// Single point in time along the projected cash flow curve
class CashFlowPointModel {
  final DateTime date;
  final double openingBalance;
  final double totalInflow;
  final double totalOutflow;
  final double closingBalance;
  final List<String> eventDescriptions;

  const CashFlowPointModel({
    required this.date,
    required this.openingBalance,
    required this.totalInflow,
    required this.totalOutflow,
    required this.closingBalance,
    this.eventDescriptions = const [],
  });

  bool get isDeficitRisk => closingBalance < 0;
}

/// Dynamic "What-If" scenario simulation item
class WhatIfScenarioModel {
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final bool isIncome;
  final bool isEnabled;

  const WhatIfScenarioModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    this.isIncome = false,
    this.isEnabled = true,
  });

  WhatIfScenarioModel copyWith({
    String? id,
    String? name,
    double? amount,
    DateTime? date,
    bool? isIncome,
    bool? isEnabled,
  }) {
    return WhatIfScenarioModel(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      isIncome: isIncome ?? this.isIncome,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

/// Full Cash Flow Projection Result
class CashFlowForecastSummary {
  final int daysHorizon; // 30, 60, or 90
  final double startingBalance;
  final double lowestBalance;
  final DateTime lowestBalanceDate;
  final double endingBalance;
  final int deficitDaysCount;
  final List<CashFlowPointModel> points;
  final List<WhatIfScenarioModel> activeScenarios;

  const CashFlowForecastSummary({
    required this.daysHorizon,
    required this.startingBalance,
    required this.lowestBalance,
    required this.lowestBalanceDate,
    required this.endingBalance,
    required this.deficitDaysCount,
    required this.points,
    this.activeScenarios = const [],
  });

  bool get hasDeficitRisk => deficitDaysCount > 0;
}
