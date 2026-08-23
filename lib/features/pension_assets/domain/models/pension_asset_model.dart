enum PensionAssetType {
  pension,
  studyFund,
  providentFund,
  managerInsurance;

  String get labelHebrew {
    switch (this) {
      case PensionAssetType.pension:
        return 'קרן פנסיה';
      case PensionAssetType.studyFund:
        return 'קרן השתלמות';
      case PensionAssetType.providentFund:
        return 'קופת גמל';
      case PensionAssetType.managerInsurance:
        return 'ביטוח מנהלים';
    }
  }

  String get dbValue {
    switch (this) {
      case PensionAssetType.pension:
        return 'pension';
      case PensionAssetType.studyFund:
        return 'study_fund';
      case PensionAssetType.providentFund:
        return 'provident_fund';
      case PensionAssetType.managerInsurance:
        return 'manager_insurance';
    }
  }

  static PensionAssetType fromDb(String val) {
    switch (val) {
      case 'pension':
        return PensionAssetType.pension;
      case 'study_fund':
      case 'studyFund':
        return PensionAssetType.studyFund;
      case 'provident_fund':
      case 'providentFund':
        return PensionAssetType.providentFund;
      case 'manager_insurance':
      case 'managerInsurance':
        return PensionAssetType.managerInsurance;
      default:
        return PensionAssetType.pension;
    }
  }
}

class PensionAssetModel {
  final String id;
  final String name;
  final PensionAssetType type;
  final String providerName; // e.g. Harel, Altshuler Shaham, Meitav
  final String? policyNumber;
  final String? trackName; // e.g. S&P 500 track, General track
  final double currentBalance;
  final double monthlyDepositEmployee;
  final double monthlyDepositEmployer;
  final DateTime lastUpdatedDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PensionAssetModel({
    required this.id,
    required this.name,
    required this.type,
    required this.providerName,
    this.policyNumber,
    this.trackName,
    required this.currentBalance,
    this.monthlyDepositEmployee = 0.0,
    this.monthlyDepositEmployer = 0.0,
    required this.lastUpdatedDate,
    required this.createdAt,
    required this.updatedAt,
  });

  double get totalMonthlyDeposit => monthlyDepositEmployee + monthlyDepositEmployer;
}
