import 'package:flutter/material.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/generated/assets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UpiPayScreen extends StatefulWidget {
  const UpiPayScreen({super.key});

  @override
  State<UpiPayScreen> createState() => _UpiPayScreenState();
}

class _UpiPayScreenState extends State<UpiPayScreen> {
  String url = '';
  late WebViewController webViewController;

  @override
  void initState() {
    url = sharedPreferences.getString('paymentUrl').toString();
    webViewController = WebViewController()..loadRequest(Uri.parse(url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: "Upi Payment",
          backbutton: true,
        ),
      ),
      body: url.isEmpty
          ? Center(
              child: Image.asset(Assets.imagesNoData),
            )
          : WebViewWidget(controller: webViewController),
    );
  }
}
