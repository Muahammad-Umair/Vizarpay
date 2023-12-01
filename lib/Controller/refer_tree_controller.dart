import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:virzanpay/Model/api.dart';
import 'package:virzanpay/Utilies/constant.dart';

class ReferTreeController extends ChangeNotifier {
  List<ReferTree> _refertreelist = [];
  List<ReferTree> _unfertreelist = [];
  int _leftRefer = 0;
  int _rightRefer = 0;
  List<ReferTree> get refertreeList => [..._refertreelist];
  List<ReferTree> get unrefertreeList => [..._unfertreelist];

  int get leftRefer => _leftRefer;
  int get rightRefer => _rightRefer;

  fetchReferalDiscussion() async {
    try {
      final url = Uri.parse(Api.referalDecision);
      String token = sharedPreferences.getString('token').toString();
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        bool status = await decodedData['status'] ?? false;
        if (status) {
          final dataMap = await decodedData["data"];
          List<ReferTree> treelist = [];
          if (dataMap != null) {
            for (var data in dataMap) {
              ReferTree referTree = ReferTree.fromMap(data);
              treelist.add(referTree);
            }
          }
          _unfertreelist = treelist;
        }
        notifyListeners();
      }
    } catch (e) {}
  }

  fetchReferalTree() async {
    try {
      final url = Uri.parse(Api.referalUser);
      String token = sharedPreferences.getString('token').toString();
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        bool status = await decodedData['status'] ?? false;
        if (status) {
          final dataMap = await decodedData["data"];

          _leftRefer = dataMap['left_users'];
          _rightRefer = dataMap['right_users'];

          List<ReferTree> treelist = [];
          if (dataMap != null) {
            var directUserList = dataMap['direct_users'];

            for (var directUser in directUserList) {
              ReferTree referTree = ReferTree.fromMap(directUser);
              treelist.add(referTree);
            }
          }
          _refertreelist = treelist;
        }
        notifyListeners();
      }
    } catch (e) {}
  }
}

class ReferTree {
  String name;
  String phone;
  String id;

  ReferTree({required this.name, required this.phone, required this.id});

  // To create an object from a map
  factory ReferTree.fromMap(Map<String, dynamic> map) {
    return ReferTree(
      id: map['id'].toString() ?? '',
      name: map['first_name'] ?? '',
      phone: map['phone_number'] ?? '',
    );
  }
}
