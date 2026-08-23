/// Domain Model for an Import Batch
class ImportBatchModel {
  final String id;
  final String sourceName; // 'Isracard', 'Leumi', 'PAGI', 'OneZero', 'Custom'
  final String fileName;
  final DateTime importedAt;
  final int totalRows;
  final int importedRows;
  final int duplicatesSkipped;
  final String status; // 'completed', 'rolled_back'
  final DateTime createdAt;

  const ImportBatchModel({
    required this.id,
    required this.sourceName,
    required this.fileName,
    required this.importedAt,
    required this.totalRows,
    required this.importedRows,
    required this.duplicatesSkipped,
    this.status = 'completed',
    required this.createdAt,
  });

  bool get isRolledBack => status == 'rolled_back';

  ImportBatchModel copyWith({
    String? id,
    String? sourceName,
    String? fileName,
    DateTime? importedAt,
    int? totalRows,
    int? importedRows,
    int? duplicatesSkipped,
    String? status,
    DateTime? createdAt,
  }) {
    return ImportBatchModel(
      id: id ?? this.id,
      sourceName: sourceName ?? this.sourceName,
      fileName: fileName ?? this.fileName,
      importedAt: importedAt ?? this.importedAt,
      totalRows: totalRows ?? this.totalRows,
      importedRows: importedRows ?? this.importedRows,
      duplicatesSkipped: duplicatesSkipped ?? this.duplicatesSkipped,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
