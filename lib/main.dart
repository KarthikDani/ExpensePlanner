import './widgets/save_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(const MyHomePage());

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (element) => element.date!.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          )!,
        )
        .toList();
  }

  void _saveTransaction(String itemName, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: itemName,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _showTransactionSavingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SaveTransaction(_saveTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 18))),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Personal Expenses")),
          actions: [
            Builder(builder: (builderContext) {
              return IconButton(
                onPressed: () => _showTransactionSavingSheet(builderContext),
                icon: const Card(
                  elevation: 1,
                  color: Colors.indigo,
                  child: Icon(
                    Icons.playlist_add,
                    size: 25,
                  ),
                ),
              );
            })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(_recentTransactions),
              TransactionList(_transactions, _deleteTransaction),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (builderContext) => FloatingActionButton(
            onPressed: () => _showTransactionSavingSheet(builderContext),
            elevation: 7,
            child: const Icon(Icons.playlist_add_outlined),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
