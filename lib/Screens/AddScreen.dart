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
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00A86B), // Splash accent color
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
    // Theme colors extracted from your SplashScreen
    const Color darkGreen = Color(0xFF0A3D2A);
    const Color emeraldGreen = Color(0xFF00A86B);
    const Color mutedGreen = Color.fromRGBO(10, 60, 40, 0.55);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Add New Expense',
          style: TextStyle(
            color: darkGreen,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkGreen),
      ),
      body: Container(
        height: double.infinity,
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                
                // Expense Type Field
                TextField(
                  controller: _typeController,
                  style: const TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Expense Type',
                    labelStyle: const TextStyle(color: mutedGreen),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    prefixIcon: const Icon(Icons.label_outline, color: emeraldGreen),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: emeraldGreen, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Amount Field
                TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: const TextStyle(color: mutedGreen),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    prefixText: '₹ ',
                    prefixStyle: const TextStyle(
                      color: emeraldGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    prefixIcon: const Icon(Icons.account_balance_wallet_outlined, color: emeraldGreen),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: emeraldGreen, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Date Selector
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: darkGreen.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: emeraldGreen.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.calendar_today_rounded,
                              color: emeraldGreen,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: mutedGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _selectedDate,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: darkGreen,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: _presentDatePicker,
                        style: TextButton.styleFrom(
                          foregroundColor: emeraldGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Change',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Submit Button
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: emeraldGreen.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _submitData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A86B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Add Expense',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}