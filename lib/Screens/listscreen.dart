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
  String? _selectedDate;

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
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Type: ${filteredList[index].type}',
                            style: TextStyle(fontSize: 18),
                          ),

                          Text(
                            'Amount: ₹${filteredList[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),

                      Spacer(),

                      Icon(Icons.edit, color: Colors.blue, size: 24),

                      Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Icon(Icons.delete, color: Colors.red, size: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,

            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
