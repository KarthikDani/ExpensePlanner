import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double totalExpenseOfTheDay = 0.0;
        for (var i = 0; i < recentTransactions.length; i++) {
          if ((recentTransactions[i].date?.day == weekDay.day) &&
              (recentTransactions[i].date?.month == weekDay.month) &&
              (recentTransactions[i].date?.year == weekDay.year)) {
            totalExpenseOfTheDay += recentTransactions[i].amount!;
          }
        }
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalExpenseOfTheDay
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(
        0.0,
        (expenseUntilNow, currentData) =>
            expenseUntilNow + (currentData['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'].toString(),
                  double.parse(data['amount'].toString()),
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
