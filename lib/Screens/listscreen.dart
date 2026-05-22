import 'dart:convert';
import 'package:expense_management/Screens/Expense.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScreen extends StatefulWidget {
  final List<Expense> expenses;

  const ListScreen({super.key, required this.expenses});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  _ListScreenState() {
    loadList();
  }

  double _total = 0.0;

  String? _selectedDate =
      '${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}';

  //Delete function
  void _deleteSpending(Expense itemtodelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: const Color(
            0xFFF3FFF9,
          ), // Matches your card gradient
          title: const Text(
            'Delete Expense',
            style: TextStyle(
              color: Color(0xFF0A3D2A),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete ${itemtodelete.type} (₹${itemtodelete.amount.toStringAsFixed(2)})?',
            style: const TextStyle(color: Color(0xFF0A3D2A), fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pop(); // Close the dialog without deleting
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF00A86B),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog first

                // Then perform the actual deletion
                setState(() {
                  widget.expenses.remove(itemtodelete);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF0A3D2A),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Deleted: ${itemtodelete.type} - ₹${itemtodelete.amount.toStringAsFixed(2)}',
                      ),
                    ),
                  );
                });
                saveList();
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //Add function
  Future<void> _NavigateAndAdd() async {
    final newExpense = await Navigator.pushNamed(context, '/add');

    if (newExpense != null && newExpense is Expense) {
      setState(() {
        widget.expenses.add(newExpense);
      });
      saveList();
    }
  }

  //Edit Function
  Future<void> _NavigateAndEdit(Expense expenseToEdit) async {
    final editedExpense = await Navigator.pushNamed(
      context,
      '/edit',
      arguments: expenseToEdit,
    );

    if (editedExpense != null && editedExpense is Expense) {
      setState(() {
        final index = widget.expenses.indexOf(expenseToEdit);

        if (index != -1) {
          widget.expenses[index] = editedExpense;
        }
      });
      saveList();
    }
  }

  //Function to store the list into string form
  Future<void> saveList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String jsonString = jsonEncode(
      widget.expenses.map((item) => item.toJson()).toList(),
    );

    await prefs.setString('my_object_list_key', jsonString);
  }

  //Function to load the string into the list
  Future<void> loadList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString('my_object_list_key');
    if (jsonString == null) return;

    List decodedData = jsonDecode(jsonString);

    List<Expense> loadedExpense = decodedData
        .map((item) => Expense.fromJson(item))
        .toList();

    setState(() {
      widget.expenses.clear();
      widget.expenses.addAll(loadedExpense);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime(2000),

      // USER CANNOT SELECT FUTURE DATES
      lastDate: DateTime.now(),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogThemeData(
              backgroundColor: const Color(0xFF140824),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),

            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFB14EFF),

              onPrimary: Colors.white,

              surface: Color(0xFF1E0D3A),

              onSurface: Colors.white,
            ),

            scaffoldBackgroundColor: const Color(0xFF140824),

            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFB14EFF),

                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,

                  fontSize: 16,
                ),
              ),
            ),

            datePickerTheme: DatePickerThemeData(
              backgroundColor: const Color(0xFF140824),

              surfaceTintColor: Colors.transparent,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),

              headerBackgroundColor: const Color(0xFFB14EFF),

              headerForegroundColor: Colors.white,

              dividerColor: Colors.white.withValues(alpha: 0.08),

              weekdayStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.65),

                fontWeight: FontWeight.w600,
              ),

              dayStyle: const TextStyle(
                color: Colors.white,

                fontWeight: FontWeight.w500,
              ),

              yearStyle: const TextStyle(color: Colors.white),

              todayForegroundColor: WidgetStateProperty.all(Colors.white),

              // CURRENT DAY BORDER
              todayBorder: BorderSide(color: const Color(0xFFB14EFF), width: 2),

              // SELECTED DAY BG
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFFB14EFF);
                }

                return Colors.transparent;
              }),

              // SELECTED DAY TEXT
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white;
                }

                // DISABLED FUTURE DATES
                if (states.contains(WidgetState.disabled)) {
                  return Colors.white.withValues(alpha: 0.18);
                }

                return Colors.white;
              }),
            ),
          ),

          child: child!,
        );
      },
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

    return Scaffold(
      backgroundColor: Colors.transparent,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Container(
        height: 65,
        width: 65,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          gradient: const LinearGradient(
            colors: [Color(0xFFB14EFF), Color(0xFF7B2DFF)],
          ),

          boxShadow: [
            BoxShadow(
              color: const Color(0xFFB14EFF).withValues(alpha: 0.45),

              blurRadius: 25,
              spreadRadius: 2,
            ),
          ],
        ),

        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,

          onPressed: _NavigateAndAdd,

          child: const Icon(Icons.add, size: 34, color: Colors.white),
        ),
      ),

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Color(0xFF0B0617),
              Color(0xFF140824),
              Color(0xFF1E0D3A),
              Color(0xFF102B4E),
            ],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 22, right: 22),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // HEADER
                const Text(
                  "TrackEx",

                  style: TextStyle(
                    fontSize: 38,

                    fontWeight: FontWeight.w800,

                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                // BALANCE CARD
                Container(
                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),

                    gradient: const LinearGradient(
                      colors: [Color(0xFFB14EFF), Color(0xFF8E44FF)],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB14EFF).withValues(alpha: 0.30),

                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Total Expenditure",

                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),

                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            '₹${_total.toStringAsFixed(2)}',

                            style: const TextStyle(
                              fontSize: 36,

                              fontWeight: FontWeight.w800,

                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // DATE FILTER
                InkWell(
                  borderRadius: BorderRadius.circular(20),

                  onTap: () => _selectDate(context),

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),

                      color: Colors.white.withValues(alpha: 0.05),

                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),

                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,

                          color: Colors.white70,
                        ),

                        const SizedBox(width: 12),

                        Text(
                          _selectedDate ?? "Select Date",

                          style: const TextStyle(
                            color: Colors.white,

                            fontSize: 16,

                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Expanded(
                  child: filteredList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Icon(
                                Icons.receipt_long,

                                size: 85,

                                color: Colors.white.withValues(alpha: 0.18),
                              ),

                              const SizedBox(height: 20),

                              Text(
                                "No Expenses Found",

                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.65),

                                  fontSize: 22,

                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredList.length,

                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 18),

                              padding: const EdgeInsets.all(18),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),

                                color: Colors.white.withValues(alpha: 0.05),

                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.04),
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.12),

                                    blurRadius: 18,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),

                              child: Row(
                                children: [
                                  // ICON
                                  Container(
                                    height: 60,
                                    width: 60,

                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,

                                      color: Colors.white.withValues(
                                        alpha: 0.08,
                                      ),
                                    ),

                                    child: const Icon(
                                      Icons.account_balance_wallet,

                                      color: Color(0xFFB14EFF),

                                      size: 26,
                                    ),
                                  ),

                                  const SizedBox(width: 18),

                                  // TEXTS
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          filteredList[index].type,

                                          style: const TextStyle(
                                            fontSize: 20,

                                            fontWeight: FontWeight.w700,

                                            color: Colors.white,
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        Text(
                                          filteredList[index].date,

                                          style: TextStyle(
                                            fontSize: 14,

                                            color: Colors.white.withValues(
                                              alpha: 0.45,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // RIGHT SIDE
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),

                                          border: Border.all(
                                            color: Colors.white.withValues(
                                              alpha: 0.08,
                                            ),
                                          ),
                                        ),

                                        child: Text(
                                          '-₹${filteredList[index].amount.toStringAsFixed(2)}',

                                          style: const TextStyle(
                                            color: Colors.white,

                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 14),

                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => _NavigateAndEdit(
                                              filteredList[index],
                                            ),

                                            child: Container(
                                              padding: const EdgeInsets.all(10),

                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,

                                                color: Colors.blue.withValues(
                                                  alpha: 0.14,
                                                ),
                                              ),

                                              child: const Icon(
                                                Icons.edit,

                                                size: 20,

                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 10),

                                          GestureDetector(
                                            onTap: () => _deleteSpending(
                                              filteredList[index],
                                            ),

                                            child: Container(
                                              padding: const EdgeInsets.all(10),

                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,

                                                color: Colors.red.withValues(
                                                  alpha: 0.14,
                                                ),
                                              ),

                                              child: const Icon(
                                                Icons.delete,

                                                size: 20,

                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
