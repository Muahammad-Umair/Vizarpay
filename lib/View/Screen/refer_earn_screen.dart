import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/Widget/button.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/generated/assets.dart';

class ReferEarnScreen extends StatelessWidget {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          centerTitle: false,
          title: "Refer & Earn",
          backbutton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.23,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
                image: const DecorationImage(
                  image: AssetImage(Assets.imagesEarn),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Text(
                    "Refer your friends and earn unlimited cash and many more",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    "For every friends that plays, you get 2% of this total game account for maximum Rs. 1000 per referal",
                    style: GoogleFonts.lato(fontSize: 14),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  Container(
                    height: size.height * 0.2,
                    width: size.width,
                    // margin: EdgeInsets.symmetric(horizontal: size.width),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 0,
                          offset: const Offset(1, 1),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(-1, -1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "SHARE YOUR INVITE CODE",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Container(
                          height: 45,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              sharedPreferences.getString('referId').toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomButton(
                            elevation: 0,
                            widget: Row(
                              children: [
                                Text(
                                  "WHATSAPP SHARE",
                                  style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            color: Colors.blueAccent,
                            ontap: () async {
                              final RenderBox box =
                                  context.findRenderObject() as RenderBox;
                              String text =
                                  'Your Referral Code to join : ${sharedPreferences.getString('referId').toString()}. You can download the app by tap on this link. ';
                              final String appLink = sharedPreferences
                                      .getString('shareUrl') ??
                                  'https://play.google.com/store/apps/details?id=com.indiaonline.virzanpay'; // Replace with your app's store link
                              final String shareText = '$text\n$appLink';
                              Share.share(shareText,
                                  sharePositionOrigin:
                                      box.localToGlobal(Offset.zero) &
                                          box.size);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
