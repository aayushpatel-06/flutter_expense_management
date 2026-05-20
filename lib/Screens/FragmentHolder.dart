import 'package:expense_management/Screens/listscreen.dart';
import 'package:expense_management/Screens/Expense.dart';
import 'package:flutter/material.dart';

class FragmentHolder extends StatefulWidget {
  FragmentHolder({super.key});

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {
  //Variable for tracking the screen , for switch case

  final List<Expense> expenses = [
    Expense(date: '15-05-2026', type: 'Groceries', amount: 1450.0),

    Expense(date: '15-05-2026', type: 'Food', amount: 320.0),

    Expense(date: '16-05-2026', type: 'Transport', amount: 180.0),

    Expense(date: '16-05-2026', type: 'Entertainment', amount: 850.0),

    Expense(date: '17-05-2026', type: 'Shopping', amount: 2499.0),

    Expense(date: '17-05-2026', type: 'Food', amount: 540.0),

    Expense(date: '18-05-2026', type: 'Utilities', amount: 2100.0),

    Expense(date: '18-05-2026', type: 'Transport', amount: 95.0),

    Expense(date: '18-05-2026', type: 'Coffee', amount: 180.0),

    Expense(date: '19-05-2026', type: 'Groceries', amount: 1320.0),

    Expense(date: '19-05-2026', type: 'Entertainment', amount: 699.0),

    Expense(date: '19-05-2026', type: 'Food', amount: 410.0),

    Expense(date: '20-05-2026', type: 'Medical', amount: 950.0),

    Expense(date: '20-05-2026', type: 'Transport', amount: 120.0),

    Expense(date: '20-05-2026', type: 'Shopping', amount: 3200.0),

    Expense(date: '21-05-2026', type: 'Subscription', amount: 499.0),

    Expense(date: '21-05-2026', type: 'Food', amount: 275.0),

    Expense(date: '21-05-2026', type: 'Fuel', amount: 1800.0),

    Expense(date: '22-05-2026', type: 'Travel', amount: 4200.0),

    Expense(date: '22-05-2026', type: 'Coffee', amount: 220.0),

    Expense(date: '22-05-2026', type: 'Entertainment', amount: 999.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListScreen(expenses: expenses));
  }
}
