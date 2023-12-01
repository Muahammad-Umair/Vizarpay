import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';
import 'package:virzanpay/generated/assets.dart';

import '../../../Model/service.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  bool loading = false;
  bool loading2 = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: "Deposit",
          backbutton: true,
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // FlipInX(
            //   duration: const Duration(seconds: 2),
            //   child: Container(
            //     // height: 100,
            //     width: size.width,
            //     padding: const EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //       color: Colors.grey.shade300,
            //       boxShadow: const [
            //         BoxShadow(
            //           color: Colors.white,
            //           offset: Offset(
            //             -1,
            //             -1,
            //           ),
            //         ),
            //         BoxShadow(
            //           color: Colors.white,
            //           offset: Offset(
            //             1,
            //             1,
            //           ),
            //         ),
            //       ],
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.pushNamed(context, Routes.manuallyrechagreScreen);
            //       },
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           const SizedBox(
            //             width: 5,
            //           ),
            //           Text(
            //             "Add Manually",
            //             style: GoogleFonts.lato(
            //               color: Colors.grey,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //             ),
            //           ),
            //           const Spacer(),
            //           SizedBox(
            //             height: 30,
            //             width: 30,
            //             child: Image.asset(Assets.imagesArrrowSide),
            //           ),
            //           const SizedBox(
            //             width: 5,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            FlipInX(
              duration: const Duration(seconds: 2),
              child: Container(
                // height: 100,
                width: size.width,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(
                        -1,
                        -1,
                      ),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(
                        1,
                        1,
                      ),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    bool premiumStatus = await ApiService.checkPremiumPrice();

                    String amount = sharedPreferences.getString('amount') ?? '';

                    print(premiumStatus);

                    if (amount.isNotEmpty && premiumStatus) {
                      bool result = await ApiService.addUpiAmount2(
                          amount: amount, context: context);
                      setState(() {
                        loading = false;
                      });
                      if (result) {
                        Navigator.pushNamed(context, Routes.upiWebviewScreen);
                      } else {}
                    } else {
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          loading
                              ? const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Colors.blueAccent,
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            width: loading ? 20 : 0,
                          ),
                          Text(
                            "Upi Gateway",
                            style: GoogleFonts.lato(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(Assets.imagesArrrowSide),
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            const Spacer(),
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
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                      // backgroundColor: Colors.lightBlueAccent,

                      // padding: EdgeInsets.symmetric(horizontal: 32.0),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
