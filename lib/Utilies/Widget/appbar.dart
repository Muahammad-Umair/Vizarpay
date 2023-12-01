import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/balance_controller.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';
import 'package:virzanpay/generated/assets.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
    this.title = "Appbar",
    this.leading,
    this.trailing,
    this.showBackbutton = true,
    this.centerTitle = true,
    this.backbutton = false,
  });
  String title;
  Widget? leading;
  List<Widget>? trailing;
  bool showBackbutton;
  bool? centerTitle;
  bool backbutton;
  @override
  Widget build(BuildContext context) {
    return SlideInDown(
      child: AppBar(
        title: Text(
          title,
          style: GoogleFonts.cairo(
              textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
        ),
        elevation: 1,
        automaticallyImplyLeading: backbutton,
        toolbarHeight: toolBarHeight,
        centerTitle: centerTitle,
        actions: trailing ??
            [
              Consumer<BalanceController>(builder: (context, controller, __) {
                return ElevatedButton.icon(
                    icon: SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(Assets.imagesEwallet)),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.walletRecharge);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    label: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        controller.balnace,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ));
              }),
            ],
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
