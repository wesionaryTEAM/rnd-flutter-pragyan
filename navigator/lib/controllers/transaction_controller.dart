import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navigator/models/boxes/boxes.dart';
import 'package:navigator/models/transactions/transaction.dart';

class TransactionController extends StateNotifier<List<Transaction>> {
  final box = Boxes.getTransactions();

  TransactionController() : super([]) {
    state = box.values.toList();
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTx =
        Transaction(id: DateTime.now().toString(), title: txTitle, amount: txAmount, date: date);

    state = [...state, newTx];
    box.add(newTx);
  }
}
