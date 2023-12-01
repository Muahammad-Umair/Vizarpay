import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/api.dart';
import '../Model/transaction.dart';
import '../Utilies/constant.dart';

class WithdrawHistoryC extends ChangeNotifier {
  List<HistoryM> _transaction = [];

  List<HistoryM> get transaction => [..._transaction];

  fetchTransaction() async {
    final url = Uri.parse(Api.withdrawhistory);
    String token = sharedPreferences.getString('token').toString();
    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = jsonDecode(response.body);

      bool status = decodedData['status'];

      if (status) {
        _transaction = [];
        var datamap = decodedData['data'];
        if (datamap != null) {
          for (var map in datamap) {
            HistoryM transaction = HistoryM.fromMap(map);
            _transaction.add(transaction);
          }
        }

        notifyListeners();
      }
    }
  }
}

class DepositHistoryC extends ChangeNotifier {
  List<HistoryM> _transaction = [];

  List<HistoryM> get transaction => [..._transaction];

  fetchTransaction() async {
    final url = Uri.parse(Api.deposithistory);
    String token = sharedPreferences.getString('token').toString();
    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = jsonDecode(response.body);

      bool status = decodedData['status'];

      if (status) {
        _transaction = [];
        var datamap = decodedData['data'];
        if (datamap != null) {
          for (var map in datamap) {
            HistoryM transaction = HistoryM.fromMap(map);
            _transaction.add(transaction);
          }
        }

        notifyListeners();
      }
    }
  }
}

class AllTransactionC extends ChangeNotifier {
  List<AllTransaction> _alltransaction = [];

  List<AllTransaction> get alltransaction => [..._alltransaction];

  fetchTransaction() async {
    final url = Uri.parse(Api.usertransaction);
    String token = sharedPreferences.getString('token').toString();
    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = jsonDecode(response.body);

      bool status = decodedData['status'];

      if (status) {
        _alltransaction = [];
        var datamap = decodedData['data'];
        if (datamap != null) {
          for (var map in datamap) {
            AllTransaction transaction = AllTransaction.fromMap(map);
            _alltransaction.add(transaction);
          }
        }

        notifyListeners();
      }
    }
  }
}
