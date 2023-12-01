import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:virzanpay/Model/api.dart';

import '../Utilies/constant.dart';

class MonthlyBonousController extends ChangeNotifier {
  String _balance = "0";
  List<MonthlyBonousM> _list = [];
  String get monthlybalance => _balance;
  List<MonthlyBonousM> get monthlyBonouslist => [..._list];

  setreferralbalance(String balance) {
    _balance = "0";
    _balance = balance;
    notifyListeners();
  }

  Future<void> checkMonthlybalance() async {
    String token = sharedPreferences.getString('token') ?? "";
    final url = Uri.parse(Api.monthlyBonousBalance);
    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = await jsonDecode(response.body);
      var status = await decodedData['status'];

      if (status && decodedData != null) {
        final balance = decodedData['data']["balance"].toString() ?? "0";
        setreferralbalance(balance);
      }
    }
  }

  Future<void> checkMonthlyBonousHistory() async {
    try {
      String token = sharedPreferences.getString('token').toString();
      final url = Uri.parse(Api.monthlyBonousHistory);
      http.Response response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        var status = await decodedData['status'];
        _list.clear();
        if (status && decodedData != null) {
          var data = await decodedData['data'];
          if (data != null) {
            for (var a in data) {
              MonthlyBonousM monthlyBonousM = MonthlyBonousM.fromMap(a);

              _list.add(monthlyBonousM);
            }
          }
        }
        notifyListeners();
      }
    } catch (e) {}
  }
}

class MonthlyBonousM {
  final int id;
  String? date;
  String? time;
  final String match;
  final String credit;
  final String debit;
  final String month;
  final String balance;

  MonthlyBonousM({
    required this.id,
    required this.date,
    required this.time,
    required this.credit,
    required this.debit,
    required this.month,
    required this.match,
    required this.balance,
  });

  // Method to convert the object to a Map

  // Static method to create an object from a Map
  static MonthlyBonousM fromMap(Map<String, dynamic> map) {
    String dateTime = map['created_at'] ?? '';
    String? date;
    String? time;
    if (dateTime.isNotEmpty) {
      final parts = dateTime.split('T');
      date = parts[0].toString();
      time = parts[1].substring(0, 5);
    }

    return MonthlyBonousM(
      id: map['id'] ?? -1,
      date: date ?? '',
      time: time ?? '',
      match: map['match'] ?? '', // Empty string if null
      month: map['month'] ?? '', // Empty string if null
      credit: map['credit'] ?? '', // Empty string if null
      debit: map['debit'] ?? '', // Empty string if null
      balance: map['balance'] ?? '', // Empty string if null
    );
  }
}
