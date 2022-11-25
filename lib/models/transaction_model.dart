class TransactionModel {
  bool isIncome;
  String title;
  num amount;
  String description;
  String createdAt;

  TransactionModel({
    required this.isIncome,
    required this.title,
    required this.amount,
    required this.description,
    required this.createdAt,
  });
}
