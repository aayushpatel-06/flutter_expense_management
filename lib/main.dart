import 'package:expense_management/Screens/AddScreen.dart';
import 'package:expense_management/Screens/EditScreen.dart';
import 'package:expense_management/Screens/Expense.dart';
import 'package:expense_management/Screens/FragmentHolder.dart';
import 'package:expense_management/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      onGenerateRoute: (settings) {
        //Navigation routes using switch case
        switch (settings.name) {
          case '/':
          case '/list':
            return MaterialPageRoute(builder: (context) => FragmentHolder());
          case '/add':
            return MaterialPageRoute(builder: (context) => AddScreen());

          case '/edit':
            final expense = settings.arguments as Expense;

            return MaterialPageRoute(
              builder: (context) => EditScreen(expense: expense),
            );

          default:
            return MaterialPageRoute(
              builder: (context) =>
                  Scaffold(body: Center(child: Text('Route Not Found'))),
            );
        }
      },
    );
  }
}
