import 'dart:convert';

/// Mapping configuration of column names or indices for CSV/Excel parsers
class ImportMappingModel {
  final String id;
  final String sourceName; // 'Isracard', 'Leumi', 'PAGI', 'OneZero', 'Custom'
  final String dateColumn;
  final String descriptionColumn;
  final String? amountColumn;
  final String? debitColumn;
  final String? creditColumn;
  final String? referenceColumn;
  final String? currencyColumn;
  final String? categoryColumn;
  final String dateFormat; // e.g. 'dd/MM/yyyy', 'yyyy-MM-dd'
  final int skipHeaderRows;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ImportMappingModel({
    required this.id,
    required this.sourceName,
    required this.dateColumn,
    required this.descriptionColumn,
    this.amountColumn,
    this.debitColumn,
    this.creditColumn,
    this.referenceColumn,
    this.currencyColumn,
    this.categoryColumn,
    this.dateFormat = 'dd/MM/yyyy',
    this.skipHeaderRows = 1,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJsonMap() {
    return {
      'dateColumn': dateColumn,
      'descriptionColumn': descriptionColumn,
      'amountColumn': amountColumn,
      'debitColumn': debitColumn,
      'creditColumn': creditColumn,
      'referenceColumn': referenceColumn,
      'currencyColumn': currencyColumn,
      'categoryColumn': categoryColumn,
      'dateFormat': dateFormat,
      'skipHeaderRows': skipHeaderRows,
    };
  }

  String toJsonString() => jsonEncode(toJsonMap());

  factory ImportMappingModel.fromJsonString({
    required String id,
    required String sourceName,
    required String jsonString,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) {
    final map = jsonDecode(jsonString) as Map<String, dynamic>;
    return ImportMappingModel(
      id: id,
      sourceName: sourceName,
      dateColumn: map['dateColumn'] as String? ?? 'תאריך',
      descriptionColumn: map['descriptionColumn'] as String? ?? 'תיאור',
      amountColumn: map['amountColumn'] as String?,
      debitColumn: map['debitColumn'] as String?,
      creditColumn: map['creditColumn'] as String?,
      referenceColumn: map['referenceColumn'] as String?,
      currencyColumn: map['currencyColumn'] as String?,
      categoryColumn: map['categoryColumn'] as String?,
      dateFormat: map['dateFormat'] as String? ?? 'dd/MM/yyyy',
      skipHeaderRows: map['skipHeaderRows'] as int? ?? 1,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
