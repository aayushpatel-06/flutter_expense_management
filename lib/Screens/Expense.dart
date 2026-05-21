class Expense {
  final String date;
  final String type;
  final double amount;
  Expense({required this.date, required this.type, required this.amount});

  Map<String, dynamic> toJson() {
    return {"date": date, "type": type, "amount": amount};
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      date: json['date'],
      type: json['type'],
      amount: json['amount'],
    );
  }
}
