import 'package:flutter/cupertino.dart';

class BalanceController extends ChangeNotifier {
  String _balance = "0";

  String get balnace => _balance;

  setBalance(var balance) {
    _balance = "0";
    _balance = balance.toString();
    notifyListeners();
  }
}
