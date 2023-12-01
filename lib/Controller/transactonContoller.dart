import 'package:flutter/material.dart';
import 'package:virzanpay/Model/transaction.dart';

class TransactionContoller extends ChangeNotifier {
  List<Transaction> _transationlist = [];
  addAll(List<Transaction> transaction) async {
    _transationlist.clear();
    _transationlist.addAll(transaction);
    notifyListeners();
  }

  List<Transaction> get transactionList => [..._transationlist.reversed];
}
