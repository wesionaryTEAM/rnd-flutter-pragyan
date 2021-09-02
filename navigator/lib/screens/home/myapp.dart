import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navigator/controllers/transaction_controller.dart';
import 'package:navigator/models/transactions/transaction.dart';
import 'package:navigator/widgets/index.dart';

final transactionNotifier =
    StateNotifierProvider<TransactionController, List<Transaction>>((ref) => TransactionController());

class RiverPodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(),
      home: MyApp(),
    );
  }
}

class MyApp extends HookConsumerWidget {
  void _startAddNewTransaction(BuildContext ctx, WidgetRef ref) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return NewTransaction(ref.read(transactionNotifier.notifier).addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses '),
        actions: [
          IconButton(onPressed: () => _startAddNewTransaction(context, ref), icon: Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(ref.watch(transactionNotifier)),
            TransactionList(ref.watch(transactionNotifier))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context, ref),
      ),
    );
  }
}
