import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:virzanpay/Model/api.dart';
import 'package:virzanpay/Utilies/Widget/snackbar.dart';
import 'package:virzanpay/Utilies/constant.dart';

class UpiTransactionContoller extends ChangeNotifier {
  List<UpiTransaction> _transationlist = [];
  addAll(List<UpiTransaction> transaction) async {
    _transationlist.clear();
    _transationlist.addAll(transaction);
    notifyListeners();
  }

  Future<bool> fetchupiHistory(BuildContext context) async {
    final tokenNew = sharedPreferences.getString("token");
    final url = Uri.parse(Api.viewtransactionApi);

    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $tokenNew',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        bool status = await decodedData['status'] ?? false;
        if (status) {
          final dataMap = await decodedData["data"];
          _transationlist = [];
          if (dataMap != null) {
            for (var data in dataMap) {
              final transaction = UpiTransaction.fromMap(data);
              _transationlist.add(transaction);
            }
            notifyListeners();
            return true;
          } else {
            return false;
          }
        } else {
          throw decodedData['messages'];
        }
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  Future<bool> checkStauts(
      {required BuildContext context,
      required String txid,
      required String date}) async {
    try {
      final url = Uri.parse(Api.checkstatus);

      final tokenNew = sharedPreferences.getString("token");

      http.Response response = await http.post(
        url,
        body: {"client_txn_id": txid, "date": date},
        headers: {
          'Authorization': 'Bearer $tokenNew',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);

        bool status = await decodedData['status'];
        if (status) {
          return true;
        } else {
          throw await decodedData['msg'] ?? '';
        }
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  List<UpiTransaction> get transactionList => [..._transationlist.reversed];
}

class UpiTransaction {
  int id;
  String userId;
  String amount;
  String transactionId;
  String type;
  String transactionStatus;
  String createDate;
  String updateDate;
  String isChecked;

  UpiTransaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.transactionId,
    required this.type,
    required this.transactionStatus,
    required this.createDate,
    required this.updateDate,
    required this.isChecked,
  });

  factory UpiTransaction.fromMap(Map<String, dynamic> map) {
    return UpiTransaction(
      id: map['id'] ?? -1,
      userId: map['user_id'] ?? '',
      amount: map['amount'],
      transactionId: map['client_txn_id'] ?? "",
      type: map['via'] ?? '',
      transactionStatus: map['transaction_status'] ?? '',
      createDate: map['created_at'] ?? "",
      updateDate: map['updated_at'] ?? '',
      isChecked: map['is_checked'] ?? "",
    );
  }
}
