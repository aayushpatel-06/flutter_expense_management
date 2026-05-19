import 'package:flutter/material.dart';
class spendings{
  final String date;
  final  String type;
  final double amount;
  spendings({required this.date, required this.type, required this.amount});
}
class MyWidget extends StatefulWidget {
  
  const MyWidget({super.key});
  

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  double _total = 0.0;
  String? _selectedDate;
  final List<spendings> _spendingsList = [
  spendings(date: '01-01-2026', type: 'Food', amount: 20.0),
  spendings(date: '02-01-2026', type: 'Transport', amount: 15.0),
  spendings(date: '03-01-2026', type: 'Entertainment', amount: 30.0),
  spendings(date: '29-03-2026', type: 'Utilities', amount: 25.0),
  spendings(date: '30-03-2026', type: 'Groceries', amount: 50.0),
  spendings(date: '01-04-2026', type: 'Entertainment', amount: 40.0),
  spendings(date: '02-04-2026', type: 'Transport', amount: 10.0),
  spendings(date: '01-01-2026', type: 'Food', amount: 20.0),
  spendings(date: '02-01-2026', type: 'Transport', amount: 15.0),
  spendings(date: '03-01-2026', type: 'Entertainment', amount: 30.0),
  spendings(date: '29-03-2026', type: 'Utilities', amount: 25.0),
  spendings(date: '30-03-2026', type: 'Groceries', amount: 50.0),
  spendings(date: '01-04-2026', type: 'Entertainment', amount: 40.0),
  spendings(date: '02-04-2026', type: 'Transport', amount: 10.0),
  spendings(date: '01-01-2026', type: 'Food', amount: 20.0),
  spendings(date: '02-01-2026', type: 'Transport', amount: 15.0),
  spendings(date: '03-01-2026', type: 'Entertainment', amount: 30.0),
  spendings(date: '29-03-2026', type: 'Utilities', amount: 25.0),
  spendings(date: '30-03-2026', type: 'Groceries', amount: 50.0),
  spendings(date: '01-04-2026', type: 'Entertainment', amount: 40.0),
  spendings(date: '02-04-2026', type: 'Transport', amount: 10.0),
];
  void _deleteSpending(spendings itemtodelete) {
    setState(() {
      _spendingsList.remove(itemtodelete);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted: ${itemtodelete.type} - ₹${itemtodelete.amount.toStringAsFixed(2)}')));
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate = '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final filteredlist = _selectedDate == null ? _spendingsList : 
    _spendingsList.where((spending) => spending.date == _selectedDate).toList();
    _total =  filteredlist.isEmpty ? 0.0 : (filteredlist.fold(0.0, (sum, item) => sum + item.amount));
    return Container(
      width: double.infinity,
      child: Column(
        children: [
              InkWell(
                onTap: () => _selectDate(context),
                child: Text(_selectedDate == null ? 'Select Filter Date' : 'Selected Date: $_selectedDate', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('${_total}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredlist.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFFFFFFF), Color(0xFFEAFBF4), Color(0xFFBDF0D8)],
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text('Type:${filteredlist[index].type}', style: TextStyle(fontSize: 18)),
                              Text('Amount: ₹${filteredlist[index].amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.edit, color: Colors.blue, size: 24),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red, size: 24),
                              onPressed: () => _deleteSpending(filteredlist[index]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add),),
                ))
            ],
          ),
      );
  }
}