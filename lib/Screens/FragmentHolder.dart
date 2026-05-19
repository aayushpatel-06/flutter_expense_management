import 'package:expense_management/Screens/listscreen.dart';
import 'package:expense_management/Screens/Expense.dart';
import 'package:flutter/material.dart';

class FragmentHolder extends StatelessWidget {
  FragmentHolder({super.key});

  final List<Expense> expenses = [
    Expense(date: '01-01-2024', type: 'Food', amount: 20.0),
    Expense(date: '02-01-2024', type: 'Transport', amount: 15.0),
    Expense(date: '03-01-2024', type: 'Entertainment', amount: 30.0),
    Expense(date: '29-03-2024', type: 'Utilities', amount: 25.0),
    Expense(date: '30-03-2024', type: 'Groceries', amount: 50.0),
    Expense(date: '01-04-2024', type: 'Entertainment', amount: 40.0),
    Expense(date: '02-04-2024', type: 'Transport', amount: 10.0),
    Expense(date: '01-01-2024', type: 'Food', amount: 20.0),
    Expense(date: '02-01-2024', type: 'Transport', amount: 15.0),
    Expense(date: '03-01-2024', type: 'Entertainment', amount: 30.0),
    Expense(date: '29-03-2024', type: 'Utilities', amount: 25.0),
    Expense(date: '30-03-2024', type: 'Groceries', amount: 50.0),
    Expense(date: '01-04-2024', type: 'Entertainment', amount: 40.0),
    Expense(date: '02-04-2024', type: 'Transport', amount: 10.0),
    Expense(date: '01-01-2024', type: 'Food', amount: 20.0),
    Expense(date: '02-01-2024', type: 'Transport', amount: 15.0),
    Expense(date: '03-01-2024', type: 'Entertainment', amount: 30.0),
    Expense(date: '29-03-2024', type: 'Utilities', amount: 25.0),
    Expense(date: '30-03-2024', type: 'Groceries', amount: 50.0),
    Expense(date: '01-04-2024', type: 'Entertainment', amount: 40.0),
    Expense(date: '02-04-2024', type: 'Transport', amount: 10.0),
  ];

  @override
  Widget build(BuildContext context) {
    return ListScreen(expenses : expenses);
  }
}
