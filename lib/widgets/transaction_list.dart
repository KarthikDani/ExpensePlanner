import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delTransFunc;

  TransactionList(this.transactions, this.delTransFunc);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notes_sharp,
                color: Colors.grey,
                size: 100,
              ),
              Text("Ready to keep an eye on your expenses?"),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 7,
                child: ListTile(
                  leading: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: Text(
                      '₹${transactions[index].amount?.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[index].title.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    DateFormat.MMMMEEEEd().format(transactions[index].date!),
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  trailing: IconButton(
                    onPressed: () => delTransFunc(transactions[index].id),
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red,
                    iconSize: 25,
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
