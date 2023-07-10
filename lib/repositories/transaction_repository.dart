import 'package:app_finance/common/models/balances_model.dart';
import '../common/models/transaction_model.dart';
import '../data/data_result.dart';

abstract class TransactionRepository {
  static const transactionsPath = 'transactions';
  static const balancesPath = 'balances';
  static const localChanges = 'local_changes';

  Future<DataResult<bool>> addTransaction({
    required TransactionModel transaction,
    required String userId,
    });

  Future<DataResult<bool>> updateTransaction(TransactionModel transaction);

  Future<DataResult<List<TransactionModel>>> getTransactions({
    int? limit,
    int? offset,
  bool latest = false,
  });

    Future<DataResult<bool>> deleteTransaction(TransactionModel transaction);
    Future<DataResult<BalancesModel>> getBalances();

    Future<void> updateBalance(TransactionModel newtTansaction);
}