import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/navcontroller.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/Widget/custom_drawer.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/View/Contact/contact.dart';
import 'package:virzanpay/View/Level/level_screen.dart';
import 'package:virzanpay/View/Profile/profile.dart';
import 'package:virzanpay/View/home/home.dart';

class NavBarScreen extends StatelessWidget {
  List<Widget> _page = [
    const HomeScreen(),
    const LevelScreen(),
    const CallScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final navController = context.watch<BottomNavController>();

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(navController.index == 3 ? 0 : toolBarHeight),
        child: navController.index == 3
            ? const SizedBox()
            : CustomAppBar(
                title: "${sharedPreferences.getString('fname')}" ?? '',
                centerTitle: false,
                backbutton: true,
              ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: navController.index,
        iconSize: 25,
        backgroundColor: Colors.blueAccent,
        onItemSelected: (value) {
          navController.changeIndex(value);
        },
        items: [
          FlashyTabBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.grey.shade300,
            ),
            title: const Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: Icon(
              Icons.star_border,
              color: Colors.grey.shade300,
            ),
            title: const Text(
              "Level",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: Icon(
              Icons.contact_support,
              color: Colors.grey.shade300,
            ),
            title: const Text(
              "Contact",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.grey.shade300,
            ),
            title: const Text(
              "Settings",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _page[navController.index],
    );
  }
}
