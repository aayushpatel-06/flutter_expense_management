import 'package:expense_management/Screens/Expense.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  final List<Expense> expenses;

  const ListScreen({super.key, required this.expenses});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  double _total = 0.0;

  String? _selectedDate =
      '${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}';

void _deleteSpending(Expense itemtodelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: const Color(0xFFF3FFF9), // Matches your card gradient
          title: const Text(
            'Delete Expense',
            style: TextStyle(
              color: Color(0xFF0A3D2A),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete ${itemtodelete.type} (₹${itemtodelete.amount.toStringAsFixed(2)})?',
            style: const TextStyle(
              color: Color(0xFF0A3D2A),
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without deleting
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

  Future<void> _NavigateAndAdd() async {
    final newExpense = await Navigator.pushNamed(context, '/add');

    if (newExpense != null && newExpense is Expense) {
      setState(() {
        widget.expenses.add(newExpense);
      });
    }
  }

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
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00A86B),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0A3D2A),
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00A86B),
        foregroundColor: Colors.white,
        elevation: 4,
        onPressed: _NavigateAndAdd,
        child: const Icon(Icons.add, size: 30),
      ),

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFD4F7F0), Color(0xFFAAE8D0), Color(0xFF66CCB0)],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 18, left: 18, right: 18),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                Text(
                  "TrackEx",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF0A3D2A),
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Track your daily spending easily",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(10, 60, 40, 0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 28),

                InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => _selectDate(context),

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),

                      borderRadius: BorderRadius.circular(18),

                      border: Border.all(
                        color: Color.fromRGBO(10, 60, 40, 0.12),
                      ),
                    ),

                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          color: Color(0xFF0A3D2A),
                        ),

                        const SizedBox(width: 12),

                        Text(
                          _selectedDate == null
                              ? 'Select Filter Date'
                              : '$_selectedDate',

                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0A3D2A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  'Total Spending',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(10, 60, 40, 0.65),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '₹${_total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0A3D2A),
                  ),
                ),

                const SizedBox(height: 30),

                Expanded(
                  child: filteredList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.receipt_long_outlined,
                                size: 85,
                                color: Color.fromRGBO(10, 60, 40, 0.25),
                              ),

                              const SizedBox(height: 18),

                              Text(
                                "No expenses found",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(10, 60, 40, 0.55),
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "Tap + to add your first expense",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(10, 60, 40, 0.45),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredList.length,

                          itemBuilder: (context, index) => Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 16),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),

                            child: Container(
                              padding: const EdgeInsets.all(18),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),

                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,

                                  colors: [
                                    Color(0xFFFFFFFF),
                                    Color(0xFFF3FFF9),
                                    Color(0xFFD9F7E8),
                                  ],
                                ),
                              ),

                              child: Row(
                                children: [
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
                                            color: Color(0xFF0A3D2A),
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        Text(
                                          '₹${filteredList[index].amount.toStringAsFixed(2)}',

                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF00A86B),
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        Text(
                                          filteredList[index].date,

                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                              10,
                                              60,
                                              40,
                                              0.5,
                                            ),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withValues(
                                            alpha: 0.1,
                                          ),
                                          shape: BoxShape.circle,
                                        ),

                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                            size: 22,
                                          ),

                                          onPressed: () => _NavigateAndEdit(
                                            filteredList[index],
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 10),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(
                                            alpha: 0.1,
                                          ),
                                          shape: BoxShape.circle,
                                        ),

                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 22,
                                          ),

                                          onPressed: () => _deleteSpending(
                                            filteredList[index],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
