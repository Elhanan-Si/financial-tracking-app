enum BriefSentiment {
  positive,
  neutral,
  warning;
}

class FinancialBriefModel {
  final String headline;
  final List<String> bulletPoints;
  final BriefSentiment sentiment;
  final DateTime generatedAt;

  const FinancialBriefModel({
    required this.headline,
    required this.bulletPoints,
    required this.sentiment,
    required this.generatedAt,
  });
}
