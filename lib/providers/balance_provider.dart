import 'package:balance_provider/models/transaction_model.dart';
import 'package:flutter/cupertino.dart';

class BalanceProvider extends ChangeNotifier {
  List<TransactionModel> transactions = [];

  void addTransaction(isIncome, title, amount, description, createdAt) {
    TransactionModel transaction = TransactionModel(
      isIncome: isIncome,
      title: title,
      amount: amount,
      description: description,
      createdAt: createdAt,
    );
    transactions.add(transaction);
    notifyListeners();
  }

  get getNumberOfTransactions => transactions.length;

  num total() {
    num total = 0;
    for (var i = 0; i < transactions.length; i++) {
      if (transactions[i].isIncome) {
        total += transactions[i].amount;
      } else {
        total -= transactions[i].amount;
      }
    }
    return total;
  }
}
