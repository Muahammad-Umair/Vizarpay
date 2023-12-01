import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:virzanpay/Model/api.dart';
import 'package:virzanpay/Utilies/Widget/snackbar.dart';
import 'package:virzanpay/Utilies/constant.dart';

class Auth {
  static Future<bool> signUp({
    required String referalCode,
    required String fname,
    required String lname,
    required String phone,
    required String password,
    required String email,
    required BuildContext context,
  }) async {
    try {
      final url = Uri.parse(Api.signupApi);

      http.Response response = await http.post(
        url,
        body: {
          'referral_code': referalCode,
          "first_name": fname,
          "last_name": lname,
          "phone_number": phone,
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        bool status = await body['status'];

        if (status) {
          String token = await body['data']['token'];
          final user = await body['data']['user'];
          int usrId = await user['id'];
          String fname = await user['first_name'];
          String lname = await user['last_name'];
          String phone = await user['phone_number'];

          await sharedPreferences.setString('fname', fname);
          await sharedPreferences.setString('lname', lname);
          await sharedPreferences.setString('phone', phone);

          sharedPreferences.setString('token', token);
          await sharedPreferences.setInt("userId", usrId);
          showSnackBar(context: context, message: "Otp send successfully");
          return true;
        } else {
          Map<String, dynamic> errors = await body["errors"];

          if (errors.containsKey('first_name')) {
            throw await errors['first_name'];
          } else if (errors.containsKey('last_name')) {
            throw await errors['last_name'];
          } else if (errors.containsKey('phone_number')) {
            throw await errors['phone_number'];
          } else if (errors.containsKey('email')) {
            throw await errors['email'];
          } else if (errors.containsKey('password')) {
            throw await errors['password'];
          }

          return false;
        }
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<String> signIn(
      {required String number,
      required String password,
      required BuildContext context}) async {
    try {
      Uri url = Uri.parse(Api.signinApi);

      http.Response response = await http.post(url, body: {
        "phone_number": number,
        "password": password,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        print(
            "Here is body$body +++++++++++++++++++++++++++++++++++++++++++++++");
        bool status = await body['status'];
        if (status) {
          String tokn = await body['data']["token"];
          final user = await body['data']['user'];
          int usrId = await user['id'];
          String fname = await user['first_name'];
          String lname = await user['last_name'];
          String phone = await user['phone_number'];
          String image = await user['profile_image'] ?? "";
          String referId = await user['referral_code'];
          await sharedPreferences.setString('token', tokn);
          await sharedPreferences.setInt('userId', usrId);
          await sharedPreferences.setString('fname', fname);
          await sharedPreferences.setString('lname', lname);
          await sharedPreferences.setString('phone', phone);
          await sharedPreferences.setString('image', image);
          await sharedPreferences.setString('referId', referId);
          await sharedPreferences.setBool('islogin', true);

          return "true";
        } else if (body['errors']['error'] == "verify_otp") {
          await sharedPreferences.setInt('userId', body['errors']['user_id']);
          return body['messages'];
        } else {
          throw body['messages'];
        }
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return "false";
    }
  }

  static Future<bool> verifyOtp({
    required String otp,
    required BuildContext context,
  }) async {
    try {
      final url = Uri.parse(Api.verifyotp);
      int userId = sharedPreferences.getInt("userId") ?? 0;

      http.Response response = await http.post(
        url,
        body: {
          "otp": otp,
          "user_id": userId.toString(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        bool status = await body['status'];

        if (status) {
          await sharedPreferences.setBool('islogIn', true);
          showSnackBar(context: context, message: "Otp successfully verified");
          return true;
        } else {
          throw body['messages'];
        }
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> resetupdatePassword({
    required String otp,
    required String password,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      final url = Uri.parse(Api.resetupdatePassword);

      http.Response response = await http.post(
        url,
        body: {
          'otp': otp,
          'phone_number': phone,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        bool status = await body['status'];

        if (status) {
          showSnackBar(
              context: context, message: "password reset successfully");
          return true;
        } else {
          throw body['messages'];
        }
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> resendOtp({
    required BuildContext context,
  }) async {
    try {
      final url = Uri.parse(Api.resendotpApi);
      final userId = sharedPreferences.getInt("userId") ?? 1;
      http.Response response = await http.post(
        url,
        body: {
          'user_id': userId.toString(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        bool status = await body['status'];

        if (status) {
          showSnackBar(context: context, message: "Otp send successfully");
          return true;
        } else {
          throw body['messages'];
        }
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }

  static Future<bool> resetPassword({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      final url = Uri.parse(Api.forgetpassword);

      http.Response response = await http.post(
        url,
        body: {
          'phone_number': phoneNumber,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        bool status = await body['status'];

        if (status) {
          showSnackBar(context: context, message: "Otp send successfully");
          return true;
        } else {
          throw body['messages'];
        }
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
      return false;
    }
  }
}
