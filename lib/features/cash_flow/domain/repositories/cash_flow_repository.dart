import '../models/cash_flow_model.dart';
import '../models/credit_card_forecast_model.dart';

/// Repository interface for Cash Flow Engine and Credit Card Forecasts
abstract class CashFlowRepository {
  Future<List<CreditCardForecastModel>> getCreditCardForecasts();

  Future<CashFlowForecastSummary> calculateCashFlowForecast({
    int days = 30,
    List<WhatIfScenarioModel> whatIfScenarios = const [],
  });
}
