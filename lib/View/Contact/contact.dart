import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virzanpay/Utilies/Widget/snackbar.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/generated/assets.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  Future<void> launchPhoneDialer(BuildContext context) async {
    final Uri phoneUri = Uri(
        scheme: "tel",
        path: sharedPreferences.getString('contactNumber') ?? "03023147342");
    try {
      await launchUrl(phoneUri);
    } catch (error) {
      showSnackBar(context: context, message: "Something went wrong");
    }
  }

  void _launchWhatsAppDialer(BuildContext context) async {
    String phoneNumber = sharedPreferences.getString('contactNumber') ??
        '+923023147342'; // Replace with the desired phone number

    var url = "whatsapp://send?phone=$phoneNumber"
        "&text=${Uri.encodeComponent("hello")}";

    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              height: size.height * 0.5,
              width: size.width,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesCallCenter),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () => _launchWhatsAppDialer(context),
                    style: ElevatedButton.styleFrom(elevation: 0),
                    child: Image.asset(Assets.imagesWhatsAppCall),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () => launchPhoneDialer(context),
                    child: Image.asset(Assets.imagesCall),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
