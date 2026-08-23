import '../models/transfer_model.dart';

/// Repository interface for internal account transfers
abstract class TransfersRepository {
  Stream<List<TransferModel>> watchTransfers({int limit = 50});
  Future<TransferModel?> getTransferById(String id);
  Future<String> createTransfer({
    required String sourceAccountId,
    required String destinationAccountId,
    required double amount,
    double? destinationAmount,
    double exchangeRate = 1.0,
    required DateTime date,
    String? note,
  });
  Future<void> deleteTransfer(String transferLinkId);
}
