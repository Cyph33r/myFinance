class Transaction {
  int id;
  String title;
  double amount;
  DateTime time;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.time,
  });

  String dfa() {
    return "Hello world";
  }
}
