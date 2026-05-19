import 'package:flutter/material.dart';
import 'package:expense_management/Screens/Expense.dart';
class EditScreen extends StatefulWidget {
  final Expense expense;

  const EditScreen({super.key, required this.expense});

  @override
  State<EditScreen> createState() => _EditScreenState();
}
class _EditScreenState extends State<EditScreen> {
  late TextEditingController _typeController;
  late TextEditingController _amountController;
  late String _selectedDate;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: widget.expense.type);
    _amountController = TextEditingController(text: widget.expense.amount.toString());
    _selectedDate = widget.expense.date;
  }

  Future<void> _presentDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  void _submitData() {
    final enteredType = _typeController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text) ?? 0.0;

    if (enteredType.isEmpty || enteredAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid type and amount.')),
      );
      return;
    }

    Navigator.of(context).pop(
      Expense(
        date: _selectedDate,
        type: enteredType,
        amount: enteredAmount,
      ),
    );
  }

  @override
  void dispose() {
    _typeController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Date: $_selectedDate'),
                Spacer(),
                ElevatedButton(
                  onPressed: _presentDatePicker,
                  child: Text('Choose Date'),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}