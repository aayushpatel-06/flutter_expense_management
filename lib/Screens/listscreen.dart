import 'package:expense_management/Screens/AddScreen.dart';
import 'package:expense_management/Screens/Expense.dart';
import 'package:expense_management/Screens/EditScreen.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  final List<Expense> expenses;

  const ListScreen({super.key, required this.expenses});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  double _total = 0.0;
  String? _selectedDate = '${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}';
  void _deleteSpending(Expense itemtodelete) {
    setState(() {
      widget.expenses.remove(itemtodelete);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Deleted: ${itemtodelete.type} - ₹${itemtodelete.amount.toStringAsFixed(2)}',
          ),
        ),
      );
    });
  }
  Future<void> _NavigateAndAdd() async {
    final newExpense = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddScreen()),
    );

    if (newExpense != null && newExpense is Expense) {
      setState(() {
        widget.expenses.add(newExpense);
      });
    }
  }

  Future<void> _NavigateAndEdit(Expense expenseToEdit) async {
    final editedExpense = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(expense: expenseToEdit)),
    );

    if (editedExpense != null && editedExpense is Expense) {
      setState(() {
        final index = widget.expenses.indexOf(expenseToEdit);
        if (index != -1) {
          widget.expenses[index] = editedExpense;
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate =
            '${picked.day.toString().padLeft(2, '0')}-'
            '${picked.month.toString().padLeft(2, '0')}-'
            '${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _selectedDate == null
        ? widget.expenses
        : widget.expenses
              .where((expense) => expense.date == _selectedDate)
              .toList();

    _total = filteredList.isEmpty
        ? 0.0
        : filteredList.fold(0.0, (sum, item) => sum + item.amount);

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          InkWell(
            onTap: () => _selectDate(context),
            child: Text(
              _selectedDate == null
                  ? 'Select Filter Date'
                  : 'Selected Date: $_selectedDate',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Total:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '$_total',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) => Card(
                elevation: 5,
                shadowColor: Colors.grey,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFEAFBF4),
                        Color(0xFFBDF0D8),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Type:${filteredList[index].type}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Amount: ₹${filteredList[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue, size: 24),
                          onPressed: () => _NavigateAndEdit(filteredList[index]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 24),
                          onPressed: () => _deleteSpending(filteredList[index]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FloatingActionButton(
                onPressed: ()=>_NavigateAndAdd(),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
