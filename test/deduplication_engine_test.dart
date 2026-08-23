import 'package:financial_tracking/features/import_export/data/deduplication/deduplication_engine.dart';
import 'package:financial_tracking/features/import_export/domain/models/duplicate_match_result.dart';
import 'package:financial_tracking/features/import_export/domain/models/parsed_transaction_row.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TASK-14: Deduplication & Fuzzy Matching Engine', () {
    const accountId = 'acc_bank_test';

    final existingTransactions = [
      TransactionModel(
        id: 'tx_existing_1',
        accountId: accountId,
        amount: 450.50,
        type: TransactionType.expense,
        date: DateTime(2026, 8, 10),
        merchantName: 'שופרסל בע"מ',
        note: 'קניות לשבת',
        categoryId: 'cat_groceries',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      TransactionModel(
        id: 'tx_existing_2',
        accountId: accountId,
        amount: 250.00,
        type: TransactionType.expense,
        date: DateTime(2026, 8, 14),
        merchantName: 'סונול דלק',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    test('Exact match is detected for same date, account, amount, and similar description', () {
      final parsedRows = [
        ParsedTransactionRow(
          rowIndex: 1,
          date: DateTime(2026, 8, 10),
          rawDescription: 'שופרסל דיל סניף מרכז',
          merchantName: 'שופרסל',
          amount: -450.50,
        ),
      ];

      final results = DeduplicationEngine.evaluateDuplicates(
        parsedRows: parsedRows,
        existingTransactions: existingTransactions,
        accountId: accountId,
      );

      expect(results.length, 1);
      expect(results[0].confidence, DuplicateConfidenceLevel.exact);
      expect(results[0].resolution, DuplicateResolutionAction.merge);
      expect(results[0].matchedTransaction?.id, 'tx_existing_1');
    });

    test('Fuzzy match is detected for date difference of 1-2 days with identical amount', () {
      final parsedRows = [
        ParsedTransactionRow(
          rowIndex: 2,
          date: DateTime(2026, 8, 15), // 1 day difference from 14/08
          rawDescription: 'סונול תחנת דלק',
          merchantName: 'סונול',
          amount: -250.00,
        ),
      ];

      final results = DeduplicationEngine.evaluateDuplicates(
        parsedRows: parsedRows,
        existingTransactions: existingTransactions,
        accountId: accountId,
      );

      expect(results.length, 1);
      expect(results[0].confidence, DuplicateConfidenceLevel.fuzzy);
      expect(results[0].matchedTransaction?.id, 'tx_existing_2');
    });

    test('Fresh transaction with no match is marked as new', () {
      final parsedRows = [
        ParsedTransactionRow(
          rowIndex: 3,
          date: DateTime(2026, 8, 20),
          rawDescription: 'חנות בגדים זארה',
          merchantName: 'זארה',
          amount: -399.00,
        ),
      ];

      final results = DeduplicationEngine.evaluateDuplicates(
        parsedRows: parsedRows,
        existingTransactions: existingTransactions,
        accountId: accountId,
      );

      expect(results.length, 1);
      expect(results[0].confidence, DuplicateConfidenceLevel.none);
      expect(results[0].resolution, DuplicateResolutionAction.importAsNew);
      expect(results[0].matchedTransaction, isNull);
    });
  });
}
