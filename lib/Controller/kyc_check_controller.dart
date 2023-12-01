import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Model/api.dart';
import '../Utilies/constant.dart';

class KycController extends ChangeNotifier {
  String kycStatus = "Pending";

  checkKycVerification() async {
    final url = Uri.parse(Api.kycCheck);
    String token = sharedPreferences.getString("token").toString();

    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print(
        "Here is the response of the kyc data +++++++++++++++++++++++++++++++++++++++${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedData = await jsonDecode(response.body);
      bool status = decodedData['status'];
      Map<String, dynamic> data = decodedData['data'];
      print("Here is data $data");
      if (status) {
        String isApproved = data['is_approved'] ?? "";
        print("Here is the filter response $isApproved");

        kycStatus = isApproved;
      }
      notifyListeners();
    } else {}
  }
}
