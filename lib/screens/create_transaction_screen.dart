import 'package:balance_provider/providers/balance_provider.dart';
import 'package:balance_provider/screens/balance_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CreateTransactionScreen extends StatefulWidget {
  CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  bool isIncome = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff56b38f),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      Radio(
                        activeColor: Color(0xff56b38f),
                        value: true,
                        groupValue: isIncome,
                        onChanged: (value) {
                          setState(() {
                            isIncome = true;
                          });
                        },
                      ),
                      Text(
                        'Income',
                        style: TextStyle(
                          color: Color(0xff56b38f),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Radio(
                        activeColor: Color(0xff56b38f),
                        value: false,
                        groupValue: isIncome,
                        onChanged: (value) {
                          setState(() {
                            isIncome = false;
                          });
                        },
                      ),
                      Text(
                        'Expense',
                        style: TextStyle(
                          color: Color(0xff56b38f),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            CustomTextFormField(
                controller: _titleCtrl, maxLines: 1, hintText: 'Title'),
            CustomTextFormField(
                controller: _amountCtrl, maxLines: 1, hintText: 'Amount'),
            CustomTextFormField(
                controller: _descriptionCtrl,
                maxLines: 3,
                hintText: 'Description'),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<BalanceProvider>(
                    context,
                    listen: false,
                  ).addTransaction(
                    isIncome,
                    _titleCtrl.text,
                    num.tryParse(_amountCtrl.text),
                    _descriptionCtrl.text,
                    DateFormat.yMMMEd().format(DateTime.now()).toString(),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff56b38f),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final int maxLines;
  final TextEditingController controller;
  final String hintText;

  CustomTextFormField({
    Key? key,
    required this.maxLines,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextFormField(
        key: Key('TextFormField'),
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
            hintText: hintText,
            filled: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
