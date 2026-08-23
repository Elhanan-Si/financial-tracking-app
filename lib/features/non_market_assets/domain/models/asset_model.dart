enum AssetType {
  realEstate,
  vehicle,
  other;

  String get labelHebrew {
    switch (this) {
      case AssetType.realEstate:
        return 'נדל"ן (דירה/קרקע)';
      case AssetType.vehicle:
        return 'רכב / כלי תחבורה';
      case AssetType.other:
        return 'נכס פיזי / פריט ערך';
    }
  }

  String get dbValue {
    switch (this) {
      case AssetType.realEstate:
        return 'real_estate';
      case AssetType.vehicle:
        return 'vehicle';
      case AssetType.other:
        return 'other';
    }
  }

  static AssetType fromDb(String val) {
    switch (val) {
      case 'real_estate':
      case 'realEstate':
        return AssetType.realEstate;
      case 'vehicle':
        return AssetType.vehicle;
      default:
        return AssetType.other;
    }
  }
}

class AssetModel {
  final String id;
  final String name;
  final AssetType assetType;
  final double estimatedValue;
  final DateTime lastValuationDate;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AssetModel({
    required this.id,
    required this.name,
    required this.assetType,
    required this.estimatedValue,
    required this.lastValuationDate,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
}
