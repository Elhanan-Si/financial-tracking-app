enum LiabilityType {
  mortgage,
  personalLoan,
  carLoan,
  other;

  String get labelHebrew {
    switch (this) {
      case LiabilityType.mortgage:
        return 'משכנתה';
      case LiabilityType.personalLoan:
        return 'הלוואה אישית';
      case LiabilityType.carLoan:
        return 'הלוואת רכב';
      case LiabilityType.other:
        return 'התחייבות אחרת';
    }
  }

  String get dbValue {
    switch (this) {
      case LiabilityType.mortgage:
        return 'mortgage';
      case LiabilityType.personalLoan:
        return 'personal_loan';
      case LiabilityType.carLoan:
        return 'car_loan';
      case LiabilityType.other:
        return 'other';
    }
  }

  static LiabilityType fromDb(String val) {
    switch (val) {
      case 'mortgage':
        return LiabilityType.mortgage;
      case 'personal_loan':
      case 'personalLoan':
        return LiabilityType.personalLoan;
      case 'car_loan':
      case 'carLoan':
        return LiabilityType.carLoan;
      default:
        return LiabilityType.other;
    }
  }
}

class LiabilityModel {
  final String id;
  final String? assetId;
  final String name;
  final LiabilityType liabilityType;
  final double initialPrincipal;
  final double currentPrincipal;
  final double interestRate; // e.g. 4.5 for 4.5%
  final double monthlyPayment;
  final int remainingPayments;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LiabilityModel({
    required this.id,
    this.assetId,
    required this.name,
    required this.liabilityType,
    required this.initialPrincipal,
    required this.currentPrincipal,
    required this.interestRate,
    required this.monthlyPayment,
    required this.remainingPayments,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });
}
