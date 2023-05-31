import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaveTransaction extends StatefulWidget {
  //SaveTransaction({super.key});
  final Function saveTransactionFunc;

  SaveTransaction(this.saveTransactionFunc);

  @override
  State<SaveTransaction> createState() => _SaveTransactionState();
}

class _SaveTransactionState extends State<SaveTransaction> {
  final _itemController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _saveDataOnDone(BuildContext context) {
    final enteredTitle = _itemController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) return;
    widget.saveTransactionFunc(_itemController.text,
        double.parse(_amountController.text), _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).viewInsets.bottom + 300,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Title of the Expense",
              ),
              controller: _itemController,
              onSubmitted: (_) => _saveDataOnDone(context),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _saveDataOnDone(context),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMMEEEEd().format(_selectedDate).toString(),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.date_range_outlined),
                    onPressed: () => _showDatePicker(context),
                    label: const Text(
                      "Choose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => _saveDataOnDone(context),
              child: const Text(
                "Save Transaction",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
