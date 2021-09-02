import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navigator/models/transactions/transaction.dart';

import '../atoms/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay).substring(0, 1), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue + double.parse(element['amount'].toString()));
  }

  Chart(this.recentTransaction);

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(20),
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'].toString(),
                      double.parse(data['amount'].toString()),
                      totalSpending == 0.0
                          ? 0.0
                          : double.parse(data['amount'].toString()) / totalSpending),
                );
              }).toList()),
        ),
      ),
    );
  }
}
