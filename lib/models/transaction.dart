class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final bool isIncome;
  final String category; // เพิ่ม category

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.category,
  });
}
