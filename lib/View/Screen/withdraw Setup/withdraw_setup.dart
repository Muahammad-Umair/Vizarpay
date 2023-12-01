import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';
import 'package:virzanpay/generated/assets.dart';

class WithdrawSetupScreen extends StatelessWidget {
  const WithdrawSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: "Withdraw Setup",
          centerTitle: false,
          backbutton: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
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
                  onTap: () {
                    Navigator.pushNamed(context, Routes.bankSetupScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Bank Account",
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(Assets.imagesArrrowSide)),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                  onTap: () {
                    Navigator.pushNamed(context, Routes.paytmSetupScreen);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => SubmitScreen(
                    //         type: "patti",
                    //         game: game,
                    //       ),
                    //     ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Paytm",
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(Assets.imagesArrrowSide),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                  onTap: () {
                    Navigator.pushNamed(context, Routes.phonePaysetupScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Phonepe",
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(Assets.imagesArrrowSide),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                  onTap: () {
                    Navigator.pushNamed(context, Routes.googlePaysetupScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Google Pay",
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
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
            )
          ],
        ),
      ),
    );
  }
}
