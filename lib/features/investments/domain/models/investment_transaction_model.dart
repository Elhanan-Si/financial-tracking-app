enum InvestmentTransactionType {
  buy,
  sell,
  dividend;

  String get labelHebrew {
    switch (this) {
      case InvestmentTransactionType.buy:
        return 'קנייה';
      case InvestmentTransactionType.sell:
        return 'מכירה';
      case InvestmentTransactionType.dividend:
        return 'דיבידנד';
    }
  }
}

class InvestmentTransactionModel {
  final String id;
  final String securityId;
  final String? securityTicker;
  final String? securityName;
  final String? holdingId;
  final InvestmentTransactionType type;
  final double quantity;
  final double pricePerUnit;
  final double fee;
  final DateTime date;
  final String currency; // 'USD', 'ILS'
  final double exchangeRateToIls;
  final DateTime createdAt;

  const InvestmentTransactionModel({
    required this.id,
    required this.securityId,
    this.securityTicker,
    this.securityName,
    this.holdingId,
    required this.type,
    required this.quantity,
    required this.pricePerUnit,
    this.fee = 0.0,
    required this.date,
    this.currency = 'USD',
    this.exchangeRateToIls = 1.0,
    required this.createdAt,
  });

  double get totalAmount => (quantity * pricePerUnit) + fee;
  double get totalAmountILS => totalAmount * exchangeRateToIls;
}
