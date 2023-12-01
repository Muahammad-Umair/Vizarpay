import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/navcontroller.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';
import 'package:virzanpay/generated/assets.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late bool isPremium = false;
  String image = '';
  @override
  void initState() {
    image = sharedPreferences.getString('image') ?? '';
    checkUser();

    super.initState();
  }

  bool loading = false;
  checkUser() async {
    isPremium = await ApiService.checkSubsciption();
    if (mounted)
      setState(() {
        isPremium;
      });
  }

  @override
  Widget build(BuildContext context) {
    final bottomC = Provider.of<BottomNavController>(context, listen: false);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF98E0FF),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: image.isNotEmpty
                        ? NetworkImage(image) as ImageProvider
                        : const AssetImage(Assets.imagesProfileImage),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Hy ${sharedPreferences.getString('fname')}" ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        isPremium ? 'Premium v1.0.0' : 'Free v1.0.0',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      isPremium
                          ? const SizedBox(
                              height: 20,
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isPremium
                                    ? Colors.blueAccent
                                    : Colors.lightBlue,
                                padding: const EdgeInsets.all(8),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.rechargeSelection);
                              },
                              child: loading
                                  ? const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Activate Premium",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )),
                    ],
                  ),
                ],
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Customlisttile2(
                      icon: const Icon(
                        Icons.home_outlined,
                        size: 22,
                      ),
                      tap: () {
                        bottomC.changeIndex(0);
                        Navigator.of(context).pop();
                      },
                      title: "Home"),
                  Customlisttile2(
                      icon: const Icon(
                        Icons.add_box_outlined,
                        size: 22,
                      ),
                      tap: () {
                        Navigator.pushNamed(context, Routes.walletRecharge);
                      },
                      title: "Add Balance"),
                  Customlisttile2(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        size: 22,
                      ),
                      tap: () {
                        Navigator.pushNamed(context, Routes.dthRechargeScreen);
                      },
                      title: "Add Dth Recharge"),
                  Customlisttile2(
                      icon: const Icon(
                        Icons.add_box,
                        size: 22,
                      ),
                      tap: () {
                        Navigator.pushNamed(
                            context, Routes.instantRechargeScreen);
                      },
                      title: "Add Mobile Recharge"),
                  Customlisttile2(
                      icon: const Icon(
                        Icons.group_outlined,
                        size: 22,
                      ),
                      tap: () async {
                        Navigator.pushNamed(
                            context, Routes.rechargeCommissionScreen);
                      },
                      title: "Recharge Commissions"),
                  Customlisttile2(
                      icon: SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset(Assets.imagesMatchingBonus)),
                      tap: () {
                        Navigator.pushNamed(
                            context, Routes.matchingbonousScreen);
                      },
                      title: "Matching Bonus"),
                  Customlisttile2(
                      icon: SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset(Assets.imagesFamilyBonous)),
                      tap: () {
                        Navigator.pushNamed(context, Routes.familybonousScreen);
                      },
                      title: "Family Bonus "),
                  Customlisttile2(
                      icon: SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset(Assets.imagesPermonusBonus)),
                      tap: () {
                        Navigator.pushNamed(
                            context, Routes.performanceBonousScreen);
                      },
                      title: "Performance Bonus"),
                  Customlisttile2(
                      icon: SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset(Assets.imagesMonthlyBonous)),
                      tap: () {
                        Navigator.pushNamed(
                            context, Routes.monthlyCommissionScreen);
                      },
                      title: "Monthly New Business Bonus"),
                  Customlisttile2(
                      icon: const Icon(
                        Icons.history,
                        size: 22,
                      ),
                      tap: () async {
                        bool status = await ApiService.DthTHistory(context);
                        if (status) {
                          Navigator.pushNamed(context, Routes.dthHistoryScreen);
                        }
                      },
                      title: "History"),
                  Customlisttile2(
                      icon: const Icon(
                        Icons.contact_support,
                        size: 22,
                      ),
                      tap: () async {
                        bottomC.changeIndex(2);
                        Navigator.of(context).pop();
                      },
                      title: "Contact Support"),
                  Customlisttile2(
                      icon: const Icon(
                        Icons.logout,
                        size: 22,
                      ),
                      tap: () async {
                        await sharedPreferences.clear();
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.signIn, (route) => false);
                      },
                      title: "Logout"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Customlisttile2 extends StatelessWidget {
  const Customlisttile2(
      {super.key, required this.icon, required this.tap, required this.title});
  final Widget icon;
  final Function()? tap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 10, bottom: 1),
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: icon,
            ),
            onTap: tap,
            title: Text(
              title,
              style: GoogleFonts.robotoSlab(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            // thickness: ,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
