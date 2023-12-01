import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virzanpay/Controller/kyc_check_controller.dart';
import 'package:virzanpay/Controller/monthly_bonous_controller.dart';
import 'package:virzanpay/Controller/referral_bonous_controller.dart';
import 'package:virzanpay/Controller/upi_transaction_controller.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';

import 'Controller/balance_controller.dart';
import 'Controller/crouse_image.dart';
import 'Controller/dthHistoty_controller.dart';
import 'Controller/family_bonous_controller.dart';
import 'Controller/history_controller.dart';
import 'Controller/matching_bonous_controller.dart';
import 'Controller/navcontroller.dart';
import 'Controller/performance_bonous_controller.dart';
import 'Controller/recharge_commission_controller.dart';
import 'Controller/refer_tree_controller.dart';
import 'Controller/transactonContoller.dart';

initDatabase() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

bool login = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initDatabase();
  login = sharedPreferences.getBool('islogin') ?? false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionContoller(),
        ),
        ChangeNotifierProvider(
          create: (context) => BalanceController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DthController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpiTransactionContoller(),
        ),
        ChangeNotifierProvider(
          create: (context) => RechargeCommissionController(),
        ),
        ChangeNotifierProvider(
          create: (context) => PerformanceBonousController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FamilyBonousController(),
        ),
        ChangeNotifierProvider(
          create: (context) => MatchingBonousController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CrouselController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReferTreeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllTransactionC(),
        ),
        ChangeNotifierProvider(
          create: (context) => DepositHistoryC(),
        ),
        ChangeNotifierProvider(
          create: (context) => WithdrawHistoryC(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReferralBonousController(),
        ),
        ChangeNotifierProvider(
          create: (context) => MonthlyBonousController(),
        ),
        ChangeNotifierProvider(
          create: (context) => KycController(),
        ),
      ],
      child: MaterialApp(
        color: Colors.lightBlueAccent,
        title: "Virzanpay",
        initialRoute: login ? Routes.NavScreen : Routes.signIn,
        debugShowCheckedModeBanner: false,
        routes: MaterialRoute.routes(),
      ),
    );
  }
}
