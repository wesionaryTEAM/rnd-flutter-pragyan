import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navigator/models/transactions/transaction.dart';

import './screens/home/myapp.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing Flutter
  await Hive.initFlutter();

  // Register Hive Adapters & opening box for that adapter
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');

  runApp(ProviderScope(child: RiverPodApp()));
}
