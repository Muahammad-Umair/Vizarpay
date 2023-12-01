import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virzanpay/Controller/balance_controller.dart';
import 'package:virzanpay/Controller/dthHistoty_controller.dart';
import 'package:virzanpay/Controller/transactonContoller.dart';
import 'package:virzanpay/Model/api.dart';
import 'package:virzanpay/Model/dthHistory.dart';
import 'package:virzanpay/Model/transaction.dart';
import 'package:virzanpay/Utilies/Widget/snackbar.dart';
import 'package:virzanpay/Utilies/constant.dart';

class ApiService {
  ApiService._();

  // static Future addPaytmBalance(
  //     {required String amount, required BuildContext context}) async {
  //   try {
  //     final time = DateTime.timestamp();
  //     final url = Uri.parse(
  //         'https://securegw-stage.paytm.in/theia/api/v1/initiateTransaction?mid=wGTGuY25794243710156&orderId=PYTM_ORDR_$time');
  //
  //     final tokenNew = sharedPreferences.getString("token");
  //     http.Response response = await http.post(
  //       url,
  //       body: json.encode({
  //         "requestType": "Payment",
  //         "mid": "wGTGuY25794243710156",
  //         "orderId": "PYTM_ORDR_$time",
  //         "websiteName": "WEBSTAGING",
  //         "txnAmount": {"value": amount, "currency": "INR"},
  //         "userInfo": {
  //           "custId": tokenNew,
  //         },
  //         "callbackUrl": "https://merchant-website.com/callback",
  //         "head": {"signature": "qasim"}
  //       }),
  //
  //       // headers: {
  //       //   'Authorization': 'Bearer $tokenNew',
  //       // },
  //     );
  //     print(
  //         "Here is response of the add balance ++++++++++++++++++++++++++++++++++++++${response.body}=====================");
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final decodedData = await jsonDecode(response.body);
  //       return decodedData;
  //     } else {
  //       print("Here is response of the body+++++++++++++++++++++${response}");
  //       throw response.body;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return e;
  //   }
  // }

  static Future<bool> addUpiAmount1(
      {required String amount, required BuildContext context}) async {
    try {
      final url = Uri.parse(Api.addUpiamountApi);

      final tokenNew = sharedPreferences.getString("token");
      http.Response response = await http.post(
        url,
        body: {
          "amount": amount,
        },
        headers: {
          'Authorization': 'Bearer $tokenNew',
        },
      );
      print(
          "Here is response of the add balance ++++++++++++++++++++++++++++++++++++++${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        bool status = await decodedData['status'] ?? false;

        if (status) {
          final data = decodedData['data'];
          int orderId = await data['order_id'];
          String paymentUrl = await data['payment_url'];
          sharedPreferences.setInt("orderId", orderId);
          sharedPreferences.setString("paymentUrl", paymentUrl);
          return true;
        } else {
          throw decodedData['msg'] ?? decodedData['messages'];
        }
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> addUpiAmount2(
      {required String amount, required BuildContext context}) async {
    try {
      final url = Uri.parse(Api.addUpiamountApi);

      final tokenNew = sharedPreferences.getString("token");
      http.Response response = await http.post(
        url,
        body: {
          "amount": amount,
          "purchase_package": 'purchase_package',
        },
        headers: {
          'Authorization': 'Bearer $tokenNew',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        bool status = await decodedData['status'] ?? false;

        if (status) {
          final data = decodedData['data'];
          int orderId = await data['order_id'];
          String paymentUrl = await data['payment_url'];
          sharedPreferences.setInt("orderId", orderId);
          sharedPreferences.setString("paymentUrl", paymentUrl);
          return true;
        } else {
          throw decodedData['msg'] ?? decodedData['messages'];
        }
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> checkSubsciption() async {
    final url = Uri.parse(Api.ispremium);

    String token = sharedPreferences.getString('token') ?? "";
    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = await jsonDecode(response.body);
      bool status = decodedData['status'] ?? false;
      if (status) {
        bool isVip = decodedData['data']['is_vip'] == '1' ? true : false;
        return isVip;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> checkPremiumPrice() async {
    final url = Uri.parse(Api.premiumPrice);
    String token = sharedPreferences.getString('token') ?? "";
    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = await jsonDecode(response.body);
      bool status = await decodedData['status'];
      if (status) {
        String amount = decodedData['data']['amount'] ?? '';
        sharedPreferences.setString('amount', amount);
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static Future<bool> termlunch(BuildContext context, String urlp) async {
    final url = Uri.parse(urlp);
    bool back = false;
    try {
      if (await canLaunchUrl(url)) {
        back = await launchUrl(url, mode: LaunchMode.inAppWebView);
        return back;
      } else {
        throw "Cannot lunch at this time";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> TransactionHistory(BuildContext context) async {
    final tokenNew = sharedPreferences.getString("token");
    final url = Uri.parse(Api.viewtransactionApi);

    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $tokenNew',
        },
      );
      print(
          "Here is all of yout transaction =========================${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        bool status = await decodedData['status'];

        if (status) {
          final dataMap = await decodedData["data"];
          List<Transaction> _transactionList = [];

          for (var data in dataMap) {
            final transaction = Transaction.fromMap(data);
            _transactionList.add(transaction);
          }
          final transactionP = context.read<TransactionContoller>();
          transactionP.addAll(_transactionList);
          return true;
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

  static Future<bool> checkStauts(
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
          throw await decodedData['msg'];
        }
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> checkBinaryStatus(
      {required String id,
      required String position,
      required BuildContext context}) async {
    String token = sharedPreferences.getString('token') ?? "";
    try {
      final url = Uri.parse(Api.referalDecisionSubmit);

      http.Response response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "user_id": id,
        'position': position,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        bool status = await decodedData['status'] ?? false;

        if (status) {
          showSnackBar(context: context, message: "Successfully");
          return true;
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

  static Future<void> checkbalance(BuildContext context) async {
    String token = sharedPreferences.getString('token') ?? "";
    // try {
    final url = Uri.parse(Api.checkBalance);
    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = await jsonDecode(response.body);
      bool status = await decodedData['status'];

      if (status) {
        final controller = context.read<BalanceController>();
        final balance = await decodedData['data']["total_balance"];
        await controller.setBalance(balance);
      }
    }
    // } catch (e) {
    //   print("Here is error=------------------------------$e");
    // }
  }

  static Future<bool> addManuallyamount(
      {required String transactionId,
      required String amount,
      required String mode,
      required BuildContext context}) async {
    try {
      final url = Uri.parse(Api.manuallyPayment);

      final tokenNew = sharedPreferences.getString("token");
      http.Response response = await http.post(
        url,
        body: {
          'transection_id': transactionId,
          'amount': amount,
          "mode": mode,
        },
        headers: {
          'Authorization': 'Bearer $tokenNew',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        bool status = await decodedData['status'];

        if (status) {
          showSnackBar(context: context, message: "Submit successfully");
          return true;
        } else {
          throw decodedData['message'];
        }
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> kyc(
      {required BuildContext context,
      required String aadharFront,
      required String aadharBack,
      required String panCard}) async {
    final url = Uri.parse(Api.kycApi);

    try {
      String token = sharedPreferences.getString("token").toString();
      http.Response response = await http.post(url, body: {
        "aadahar_front": aadharFront,
        "aadahr_back": aadharBack,
        "pan_card": panCard,
      }, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        bool status = await decodedData['status'];

        if (status) {
          showSnackBar(
              context: context, message: "Validation submit successfully");
          return true;
        } else {
          throw decodedData["messages"];
        }
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> dthRecharge(
      {required BuildContext context,
      required String number,
      required String operator,
      required String amount}) async {
    try {
      final url = Uri.parse(Api.dthrecharegeApi);
      String token = sharedPreferences.getString("token").toString();

      http.Response response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "mobile": number,
        // "alert_number": alertN,
        "amount": amount,
        "type": operator,
      });
      print(
          "Here is response of recharge numbr ${response.body}======================================");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);

        var status = await decodedData['errorcode'];

        if (status == '200') {
          showSnackBar(
              context: context, message: "Account recharge successfully");
          return true;
        } else {
          throw decodedData["messages"];
        }
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> DthTHistory(BuildContext context) async {
    final tokenNew = sharedPreferences.getString("token");
    final url = Uri.parse(Api.dthHistory);

    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $tokenNew',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = await jsonDecode(response.body);
        bool status = await decodedData['status'];

        if (status) {
          final dataMap = await decodedData["data"];
          List<Dth> _transactionList = [];

          for (var data in dataMap) {
            final transaction = Dth.fromMap(data);
            _transactionList.add(transaction);
          }
          final transactionP = context.read<DthController>();
          transactionP.addAll(_transactionList);
          return true;
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

  static Future<bool> updateNameImage({
    required BuildContext context,
    required String imagebase64,
    required String name,
  }) async {
    try {
      final url = Uri.parse(Api.updateNameImage);
      String token = sharedPreferences.getString('token').toString();
      print(imagebase64);
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "profile_image": imagebase64,
          "first_name": name,
        },
      );
      print(
          "Here is reesponse that comes after the change of images. ${response.body}====================");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        bool status = decodedData['status'];
        if (status) {
          var data = decodedData['data'];
          if (data != null) {
            String name = data['first_name'] ?? '';
            String phone = data['phone_number'] ?? "";
            String image = data['profile_image'] ?? "";
            await sharedPreferences.setString('name', name);
            await sharedPreferences.setString('phone', phone);
            await sharedPreferences.setString('image', image);
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

  static Future<bool> updatePassword({
    required BuildContext context,
    required String oldpassword,
    required String newpassword,
  }) async {
    try {
      final url = Uri.parse(Api.updatePassword);
      String token = sharedPreferences.getString('token').toString();
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "old_password": oldpassword,
          "new_password": newpassword,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        bool status = decodedData['status'] ?? false;
        if (status) {
          showSnackBar(
              context: context, message: "Password update successfully");
          return true;
        } else {
          throw decodedData['messages'];
        }
      } else {
        // throw "Something went wrong";
        throw response.statusCode;
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> updateWithdraw({
    required BuildContext context,
    String bankName = '',
    String beneficiaryName = '',
    String bankAccountNo = '',
    String bankIfscCode = '',
    String bhimAddress = '',
    String paytmAddress = '',
    String phonepayAddress = '',
  }) async {
    try {
      final url = Uri.parse(Api.updatePaymentMethod);
      String token = sharedPreferences.getString('token').toString();
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "bank_name": bankName,
          "beneficiary_name": beneficiaryName,
          "bank_account_no": bankAccountNo,
          "bank_ifsc_code": bankIfscCode,
          "bhim_address": bhimAddress,
          "paytm_address": paytmAddress,
          "phonepay_address": phonepayAddress,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        bool status = decodedData['status'] ?? false;
        if (status) {
          showSnackBar(
              context: context, message: "Account update successfully");
          return true;
        } else {
          throw decodedData['messages'];
        }
      } else {
        // throw "Something went wrong";
        throw response.statusCode;
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  // static Future<bool> instantRecharge(
  //     {required BuildContext context,
  //     required String number,
  //     required String alertN,
  //     required String amount}) async {
  //   try {
  //     final url = Uri.parse(Api.dthrecharegeApi);
  //     String token = await sharedPreferences.getString("token").toString();
  //
  //     http.Response response = await http.post(url, headers: {
  //       'Authorization': 'Bearer $token',
  //     }, body: {
  //       "mobile": number,
  //       "alert_number": alertN,
  //       "amount": amount,
  //       "type": "116"
  //     });
  //     final decodedData = await jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       String status = await decodedData['errorcode'];
  //
  //       if (status == "200") {
  //         showSnackBar(context: context, message: "Dth recharge successfully");
  //         return true;
  //       } else {
  //         throw decodedData["msg"];
  //       }
  //     } else {
  //       throw decodedData["msg"];
  //     }
  //   } catch (e) {
  //     showSnackBar(context: context, message: e.toString(), error: true);
  //     return false;
  //   }
  // }
}
