enum SecurityType {
  stock,
  etf,
  bond,
  benchmark;

  String get labelHebrew {
    switch (this) {
      case SecurityType.stock:
        return 'מניה';
      case SecurityType.etf:
        return 'קרן סל (ETF)';
      case SecurityType.bond:
        return 'אג"ח';
      case SecurityType.benchmark:
        return 'מדד ייחוס';
    }
  }
}

class SecurityModel {
  final String id;
  final String ticker;
  final String name;
  final SecurityType securityType;
  final String? exchange;
  final String currency; // 'USD', 'ILS', etc.
  final double currentPrice;
  final DateTime? lastPriceUpdate;
  final bool isBenchmark;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SecurityModel({
    required this.id,
    required this.ticker,
    required this.name,
    required this.securityType,
    this.exchange,
    this.currency = 'USD',
    this.currentPrice = 0.0,
    this.lastPriceUpdate,
    this.isBenchmark = false,
    required this.createdAt,
    required this.updatedAt,
  });

  SecurityModel copyWith({
    String? id,
    String? ticker,
    String? name,
    SecurityType? securityType,
    String? exchange,
    String? currency,
    double? currentPrice,
    DateTime? lastPriceUpdate,
    bool? isBenchmark,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SecurityModel(
      id: id ?? this.id,
      ticker: ticker ?? this.ticker,
      name: name ?? this.name,
      securityType: securityType ?? this.securityType,
      exchange: exchange ?? this.exchange,
      currency: currency ?? this.currency,
      currentPrice: currentPrice ?? this.currentPrice,
      lastPriceUpdate: lastPriceUpdate ?? this.lastPriceUpdate,
      isBenchmark: isBenchmark ?? this.isBenchmark,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
