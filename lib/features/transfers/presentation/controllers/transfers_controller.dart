import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../../data/repositories/transfers_repository_impl.dart';
import '../../domain/models/transfer_model.dart';
import '../../domain/repositories/transfers_repository.dart';

final transfersRepositoryProvider = Provider<TransfersRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final accountsRepo = ref.watch(accountsRepositoryProvider);
  return TransfersRepositoryImpl(db, accountsRepo);
});

final transfersStreamProvider = StreamProvider<List<TransferModel>>((ref) {
  final repo = ref.watch(transfersRepositoryProvider);
  return repo.watchTransfers();
});

final transfersControllerProvider = Provider<TransfersController>((ref) {
  final repo = ref.watch(transfersRepositoryProvider);
  return TransfersController(repo);
});

class TransfersController {
  final TransfersRepository _repo;

  TransfersController(this._repo);

  Future<String> executeTransfer({
    required String sourceAccountId,
    required String destinationAccountId,
    required double amount,
    double? destinationAmount,
    double exchangeRate = 1.0,
    required DateTime date,
    String? note,
  }) async {
    return await _repo.createTransfer(
      sourceAccountId: sourceAccountId,
      destinationAccountId: destinationAccountId,
      amount: amount,
      destinationAmount: destinationAmount,
      exchangeRate: exchangeRate,
      date: date,
      note: note,
    );
  }

  Future<void> deleteTransfer(String transferLinkId) async {
    await _repo.deleteTransfer(transferLinkId);
  }
}
