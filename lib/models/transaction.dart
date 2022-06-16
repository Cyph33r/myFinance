class Transaction {
  final int id;
  String title;
  double amount;
  DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  String toString() {
    return '[id: $id\ntitle: $title\namount: $amount\ndate: $date\n]';
  }
}
