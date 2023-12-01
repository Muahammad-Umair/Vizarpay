import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paytm/paytm.dart';
import 'package:provider/provider.dart';
// import 'package:upi_india/upi_india.dart';
import 'package:virzanpay/Controller/balance_controller.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/Widget/textfield.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';
import 'package:virzanpay/generated/assets.dart';

class WalletRechargeScreen extends StatefulWidget {
  const WalletRechargeScreen({super.key});

  @override
  State<WalletRechargeScreen> createState() => _WalletRechargeScreenState();
}

class _WalletRechargeScreenState extends State<WalletRechargeScreen> {
  late TextEditingController controller;
  // late UpiIndia upiIndia;
  @override
  void initState() {
    controller = TextEditingController();
    // upiIndia = UpiIndia();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  //this is loading for the add balance button
  bool loading = false;

  // this is for the loading of view button
  bool loading2 = false;

  // Future<void> initiateTransaction(UpiApp app) async {
  //   // Replace with your UPI ID
  //   // String upiAddress = 'indiaos@ybl';
  //   // String upiAddress = '7098504030@okbizaxis';
  //   String upiAddress = 'q163397279@ybl';
  //
  //   // Generate a unique transaction ID
  //   // String uniqueTransactionId = await Uuid().v4();
  //
  //   // Create a UPI transaction data
  //   await upiIndia
  //       .startTransaction(
  //     app: app,

  //     receiverUpiId: upiAddress,
  //     receiverName: 'India Online Solution',
  //     transactionRefId: "TestingUpiIndiaPlugin",
  //     transactionNote: 'Test Transaction',
  //     amount: double.parse(controller.text),
  //   )
  //       .then((response) async {
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Transaction Result'),
  //             content: Column(
  //               children: [
  //                 Text(response.status == UpiPaymentStatus.SUCCESS
  //                     ? 'Transaction successful! Transaction ID: ${response.transactionId}'
  //                     : 'Transaction failed. Reason: ${response.status}'),
  //                 Text("Transation id: ${response.transactionId}"),
  //                 Text("Transation response code: ${response.responseCode}"),
  //                 Text("Transation refernece no: ${response.approvalRefNo}"),
  //                 Text("Approval refernece no: ${response.approvalRefNo}"),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context); // Close the dialog
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         });
  //   });
  //
  //   // Show a dialog with the transaction result
  //
  //   // );
  // }
  //

  bool testing = false;

  Future<void> generateTxnToken(int mode) async {
    String payment_response = "";
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
            ? 'https://securegw-stage.paytm.in'
            : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
    //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server
    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    var body = await json.encode({
      "mid": "WebHos32378446216792",
      "key_secret": "9xhvwj1l0V#3SE2s",
      "website": "DEFAULT",
      "orderId": orderId,
      "amount": controller.text.toString(),
      "callbackUrl": callBackUrl,
      "custId": "122",
      "mode": mode.toString(),
      "testing": testing ? 0 : 1
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      print("Response is");
      print(response.body);
      String txnToken = response.body;
      setState(() {
        payment_response = txnToken;
      });

      var paytmResponse = Paytm.payWithPaytm(
          mId: "wGTGuY25794243710156",
          orderId: orderId,
          txnToken: txnToken,
          txnAmount: controller.text,
          callBackUrl: callBackUrl,
          staging: false);

      paytmResponse.then((value) {
        print(value);
        setState(() {
          loading = false;
          print("Value is ");
          print(value);
          if (value['error']) {
            payment_response = value['errorMessage'];
          } else {
            if (value['response'] != null) {
              payment_response = value['response']['STATUS'];
            }
          }
          payment_response += "\n" + value.toString();
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final balanceContoller = context.read<BalanceController>();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: "Account Recharge",
          centerTitle: false,
          trailing: [
            const SizedBox(),
          ],
          backbutton: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  Assets.imagesLogo,
                  width: size.width * 0.65,
                  height: size.height * 0.3,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomTextField(
                      controller: controller,
                      labelText: "Amount",
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return "Amount should not be empty";
                        }
                        return null;
                      },
                      keyboadType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: size.height * 0.06,
              width: size.width,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading2 = true;
                  });

                  bool result = await ApiService.TransactionHistory(context);
                  if (result) {
                    setState(() {
                      loading2 = false;
                    });
                    Navigator.pushNamed(context, Routes.TranscationHistory);
                  }
                  setState(() {
                    loading2 = false;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading2
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10)
                                .copyWith(left: 0, right: 10),
                            child: const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    Text(
                      'View Transactions',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // padding: EdgeInsets.symmetric(horizontal: 32.0),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: size.height * 0.06,
              width: size.width,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });

                    // await EasyUpiPaymentPlatform.instance
                    //     .startPayment(
                    //   await EasyUpiPaymentModel(
                    //     payeeVpa: '9800600744@pz',
                    //     payeeName: 'India Online Solution',
                    //     amount: double.parse(controller.text),
                    //     description: 'Testing payment',
                    //   ),
                    // )
                    //     .then((response) {
                    //   showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return AlertDialog(
                    //           title: Text('Transaction Result'),
                    //           content: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Text("Here is response ${response?.amount}"),
                    //               Text(
                    //                   "Transation id: ${response?.transactionId}"),
                    //               Text(
                    //                   "Transation response code: ${response?.responseCode}"),
                    //               Text(
                    //                   "Transation refernece no: ${response?.approvalRefNo}"),
                    //               Text(
                    //                   "Approval refernece no: ${response?.approvalRefNo}"),
                    //             ],
                    //           ),
                    //           actions: [
                    //             TextButton(
                    //               onPressed: () {
                    //                 Navigator.pop(context); // Close the dialog
                    //               },
                    //               child: Text('OK'),
                    //             ),
                    //           ],
                    //         );
                    //       });
                    // });

                    await generateTxnToken(1);

                    setState(() {
                      loading = false;
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10)
                                .copyWith(left: 0, right: 10),
                            child: const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    Text(
                      'Add Balance',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // padding: EdgeInsets.symmetric(horizontal: 32.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// await EasyUpiPaymentPlatform.instance
//     .startPayment(
//   EasyUpiPaymentModel(
//     payeeVpa: 'indiaos@ybl',
//     payeeName:
//     amount: double.parse(controller.text),
//     description: 'Testing payment',
//   ),
// )
//     .then((response) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Transaction Result'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("Here is response ${response?.amount}"),
//               Text(
//                   "Transation id: ${response?.transactionId}"),
//               Text(
//                   "Transation response code: ${response?.responseCode}"),
//               Text(
//                   "Transation refernece no: ${response?.approvalRefNo}"),
//               Text(
//                   "Approval refernece no: ${response?.approvalRefNo}"),
//             ],
//           ),
//           actions: [
//             ssTextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       });
//
//   // TODO: add your success logic here
//
//   // on EasyUpiPaymentException {
//   // TODO: add your exception logic here
//   // }
//
//   // bool result = await ApiService.addUpiAmount1(
//   //     amount: controller.text, context: context);
//   //
//   // if (result) {
//   //   setState(() {
//   //     loading = false;
//   //   });
//   //   String url = await sharedPreferences
//   //       .getString('paymentUrl')
//   //       .toString();
//   //   await ApiService.termlunch(context, url);
//   //   ApiService.checkbalance(context);
//   // }
//
//   setState(() {
//     loading = false;
//   });
// });
