import 'package:hive/hive.dart';
import 'package:navigator/models/transactions/transaction.dart';

class HiveBox {
  static Box<Transaction> getTransactions() => Hive.box<Transaction>('transactions');
}
