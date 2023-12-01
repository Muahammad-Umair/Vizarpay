import 'package:flutter/material.dart';

import '../Model/dthHistory.dart';

class DthController extends ChangeNotifier {
  List<Dth> _transationlist = [];
  addAll(List<Dth> transaction) async {
    _transationlist.clear();
    _transationlist.addAll(transaction);
    notifyListeners();
  }

  List<Dth> get transactionList => [..._transationlist.reversed];
}
