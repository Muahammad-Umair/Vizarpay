import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:virzanpay/Model/api.dart';

import '../Utilies/constant.dart';

class RechargeCommissionController extends ChangeNotifier {
  String _balance = "0";
  List<RechargeCommissionM> _list = [];
  String get rechargebalance => _balance;
  List<RechargeCommissionM> get rechargeCommissionlist => [..._list];

  setrerechargebalance(String balance) {
    _balance = "0";
    _balance = balance;
    notifyListeners();
  }

  Future<void> checkrechargeebalance() async {
    String token = sharedPreferences.getString('token') ?? "";
    final url = Uri.parse(Api.rechargeCommisionBalance);
    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
print("Here is balance of recahage commission ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = await jsonDecode(response.body);
      var status = await decodedData['status'];

      if (status) {
        final balance = decodedData['data']["balance"].toString();
        setrerechargebalance(balance);
      }
    }
  }

  Future<void> checkRechargeCommission() async {
    try {
      String token = sharedPreferences.getString('token').toString();
      final url = Uri.parse(Api.rechargeCommision);
      http.Response response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        var status = await decodedData['status'];
        _list.clear();
        if (status) {
          var data = await decodedData['data'];
          if (data != null) {
            for (var a in data) {
              RechargeCommissionM rechargeCommissionM =
                  RechargeCommissionM.fromMap(a);

              _list.add(rechargeCommissionM);
            }
          }
        }
        notifyListeners();
      }
    } catch (e) {}
  }
}

class RechargeCommissionM {
  final int id;
  String? date;
  String? time;
  final String userName1;
  final String userName2;
  final String status;
  final String credit;
  final String debit;
  final String balance;

  RechargeCommissionM({
    required this.id,
    required this.date,
    required this.time,
    required this.userName1,
    required this.userName2,
    required this.status,
    required this.credit,
    required this.debit,
    required this.balance,
  });

  // Method to convert the object to a Map

  // Static method to create an object from a Map
  static RechargeCommissionM fromMap(Map<String, dynamic> map) {
    String dateTime = map['created_at'] ?? '';
    String? date;
    String? time;
    if (dateTime.isNotEmpty) {
      final parts = dateTime.split('T');
      date = parts[0].toString();
      time = parts[1].substring(0, 5);
    }

    return RechargeCommissionM(
      id: map['id'] ?? -1,
      date: date ?? '',
      time: time ?? '',
      userName1: map['userName1'] ?? '', // Empty string if null
      userName2: map['userName2'] ?? '', // Empty string if null
      status: map['status'] ?? '', // Empty string if null
      credit: map['credit'] ?? '', // Empty string if null
      debit: map['debit'] ?? '', // Empty string if null
      balance: map['balance'] ?? '', // Empty string if null
    );
  }
}
