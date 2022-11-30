import 'package:balance_provider/models/transaction_model.dart';
import 'package:balance_provider/providers/balance_provider.dart';
import 'package:balance_provider/screens/create_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final test = Provider.of<BalanceProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              color: const Color(0xff56b38f),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'BALANCE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '\$ ${Provider.of<BalanceProvider>(context, listen: true).total()} USD',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    key: Key('createButton'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateTransactionScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create',
                      style: TextStyle(
                        color: Color(0xff56b38f),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer<BalanceProvider>(
                builder: (context, obj, child) {
                  List<TransactionModel> transactions = test.transactions;
                  if (transactions.isEmpty) {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: ((context, index) {
                        TransactionModel transaction = transactions[index];
                        return transaction_widget(
                          title: transaction.title,
                          amount: transaction.amount,
                          isIncome: transaction.isIncome,
                          createAt: transaction.createdAt,
                        );
                      }),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class transaction_widget extends StatelessWidget {
  String title;
  num amount;
  bool isIncome;
  String createAt;

  transaction_widget({
    Key? key,
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.createAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(
                createAt,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          isIncome
              ? Text(
                  "+${amount.toString()}",
                  style: TextStyle(
                    color: Color(0xff56b38f),
                    fontSize: 18,
                  ),
                )
              : Text(
                  "-${amount.toString()}",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                )
        ],
      ),
    );
  }
}
