// AddScreen.dart
import 'package:flutter/material.dart';
import 'package:expense_management/Screens/Expense.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _typeController = TextEditingController();
  final _amountController = TextEditingController();

  String _selectedDate =
      '${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}';

  Future<void> _presentDatePicker() async {
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
            '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  void _submitData() {
    final enteredType = _typeController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text) ?? 0.0;

    if (enteredType.isEmpty || enteredAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid type and amount.'),
          backgroundColor: const Color(0xFF0A3D2A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    Navigator.of(context).pop(
      Expense(date: _selectedDate, type: enteredType, amount: enteredAmount),
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
      extendBodyBehindAppBar: true,

      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        centerTitle: true,

        iconTheme: const IconThemeData(color: Colors.white),

        title: const Text(
          "Add Expense",

          style: TextStyle(
            color: Colors.white,

            fontWeight: FontWeight.w800,

            fontSize: 26,
          ),
        ),
      ),

      body: Container(
        height: double.infinity,
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),

                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,

                    colors: [
                      Colors.white.withValues(alpha: 0.08),

                      Colors.white.withValues(alpha: 0.04),
                    ],
                  ),

                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),

                      blurRadius: 25,

                      offset: const Offset(0, 14),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    Text(
                      "Add your Expense.",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.58),

                        fontSize: 23,

                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 34),

                    // CATEGORY FIELD
                    Container(
                      height: 70,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),

                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.06),

                            Colors.white.withValues(alpha: 0.03),
                          ],
                        ),

                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),

                      child: TextField(
                        controller: _typeController,

                        style: const TextStyle(
                          color: Colors.white,

                          fontSize: 17,

                          fontWeight: FontWeight.w600,
                        ),

                        decoration: InputDecoration(
                          border: InputBorder.none,

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 24,
                          ),

                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),

                            child: Container(
                              height: 52,
                              width: 52,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                color: const Color(
                                  0xFFB14EFF,
                                ).withValues(alpha: 0.16),
                              ),

                              child: const Icon(
                                Icons.category_rounded,

                                color: Color(0xFFB14EFF),

                                size: 26,
                              ),
                            ),
                          ),

                          hintText: "Expense Category",

                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.38),

                            fontSize: 16,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // AMOUNT FIELD
                    Container(
                      height: 70,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),

                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.06),

                            Colors.white.withValues(alpha: 0.03),
                          ],
                        ),

                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),

                      child: TextField(
                        controller: _amountController,

                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),

                        style: const TextStyle(
                          color: Colors.white,

                          fontSize: 17,

                          fontWeight: FontWeight.w600,
                        ),

                        decoration: InputDecoration(
                          border: InputBorder.none,

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 24,
                          ),

                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),

                            child: Container(
                              height: 52,
                              width: 52,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                color: const Color(
                                  0xFFB14EFF,
                                ).withValues(alpha: 0.16),
                              ),

                              child: const Icon(
                                Icons.currency_rupee_rounded,

                                color: Color(0xFFB14EFF),

                                size: 26,
                              ),
                            ),
                          ),

                          hintText: "Expense Amount",

                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.38),

                            fontSize: 16,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // DATE CARD
                    Container(
                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),

                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.06),

                            Colors.white.withValues(alpha: 0.03),
                          ],
                        ),

                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  color: const Color(
                                    0xFFB14EFF,
                                  ).withValues(alpha: 0.14),
                                ),

                                child: const Icon(
                                  Icons.calendar_month,

                                  color: Color(0xFFB14EFF),
                                ),
                              ),

                              const SizedBox(width: 16),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "Expense Date",

                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.45,
                                      ),

                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    _selectedDate,

                                    style: const TextStyle(
                                      color: Colors.white,

                                      fontSize: 17,

                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          GestureDetector(
                            onTap: _presentDatePicker,

                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),

                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFB14EFF),
                                    Color(0xFF7B2DFF),
                                  ],
                                ),
                              ),

                              child: const Text(
                                "Change",

                                style: TextStyle(
                                  color: Colors.white,

                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 34),

                    // BUTTON
                    Container(
                      height: 55,
                      width: 150,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),

                        gradient: const LinearGradient(
                          colors: [Color(0xFFB14EFF), Color(0xFF7B2DFF)],
                        ),
                      ),

                      child: ElevatedButton(
                        onPressed: _submitData,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,

                          shadowColor: Colors.transparent,

                          padding: const EdgeInsets.symmetric(vertical: 16),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),

                        child: const Text(
                          "Add Expense",

                          style: TextStyle(
                            color: Colors.white,

                            fontSize: 18,

                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
