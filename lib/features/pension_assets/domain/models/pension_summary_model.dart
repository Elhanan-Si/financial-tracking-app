import 'pension_asset_model.dart';

class PensionSummaryModel {
  final double totalPensionValue;
  final double totalStudyFundValue;
  final double totalProvidentFundValue;
  final double totalCombinedValue;
  final double totalMonthlyContributions;
  final List<PensionAssetModel> assets;

  const PensionSummaryModel({
    required this.totalPensionValue,
    required this.totalStudyFundValue,
    required this.totalProvidentFundValue,
    required this.totalCombinedValue,
    required this.totalMonthlyContributions,
    required this.assets,
  });

  factory PensionSummaryModel.fromAssets(List<PensionAssetModel> assets) {
    double pension = 0.0;
    double study = 0.0;
    double provident = 0.0;
    double totalContributions = 0.0;

    for (final a in assets) {
      if (a.type == PensionAssetType.pension || a.type == PensionAssetType.managerInsurance) {
        pension += a.currentBalance;
      } else if (a.type == PensionAssetType.studyFund) {
        study += a.currentBalance;
      } else if (a.type == PensionAssetType.providentFund) {
        provident += a.currentBalance;
      }
      totalContributions += a.totalMonthlyDeposit;
    }

    return PensionSummaryModel(
      totalPensionValue: pension,
      totalStudyFundValue: study,
      totalProvidentFundValue: provident,
      totalCombinedValue: pension + study + provident,
      totalMonthlyContributions: totalContributions,
      assets: assets,
    );
  }
}
