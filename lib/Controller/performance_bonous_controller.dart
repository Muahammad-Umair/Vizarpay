import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/api.dart';
import '../Utilies/constant.dart';

class PerformanceBonousController extends ChangeNotifier {
  String _balance = "0";
  final List<PerformanceBonusM> _list = [];
  String get performanceBonousbalance => _balance;
  List<PerformanceBonusM> get performaceBonouslist => [..._list];

  setreperformancebalance(String balance) {
    _balance = "0";
    _balance = balance;
    notifyListeners();
  }

  Future<void> checkPerformancebalance() async {
    String token = sharedPreferences.getString('token') ?? "";
    final url = Uri.parse(Api.performanceBonousBalance);
    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = await jsonDecode(response.body);
      var status = await decodedData['status'];

      if (status) {
        final balance = decodedData['data']["balance"].toString();
        setreperformancebalance(balance);
      }
    }
  }

  Future<void> checkPerformancebonou() async {
    try {
      String token = sharedPreferences.getString('token').toString();
      final url = Uri.parse(Api.performanceBonous);
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
              PerformanceBonusM performanceBonusM =
                  PerformanceBonusM.fromMap(a);
              _list.add(performanceBonusM);
            }
          }
        }
        notifyListeners();
      }
    } catch (e) {}
  }
}

class PerformanceBonusM {
  final int id;
  String? date;
  String? time;
  final String userName1;
  final String userName2;
  final String status;
  final String credit;
  final String debit;
  final String balance;

  PerformanceBonusM({
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
  static PerformanceBonusM fromMap(Map<String, dynamic> map) {
    String dateTime = map['created_at'] ?? '';
    String? date;
    String? time;
    if (dateTime.isNotEmpty) {
      final parts = dateTime.split('T');
      date = parts[0].toString();
      time = parts[1].substring(0, 5);
    }

    return PerformanceBonusM(
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
