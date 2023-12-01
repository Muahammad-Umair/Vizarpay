import 'package:flutter/cupertino.dart';
import 'package:virzanpay/View/Navbar/navbar.dart';
import 'package:virzanpay/View/Screen/Add%20Balance/add_manually.dart';
import 'package:virzanpay/View/Screen/Add%20Balance/selection_screen.dart';
import 'package:virzanpay/View/Screen/Add%20Balance/upi_pay_screen.dart';
import 'package:virzanpay/View/Screen/account_update.dart';
import 'package:virzanpay/View/Screen/add_balance.dart';
import 'package:virzanpay/View/Screen/all_transaction.dart';
import 'package:virzanpay/View/Screen/depositHistory_screen.dart';
import 'package:virzanpay/View/Screen/dth_histroy.dart';
import 'package:virzanpay/View/Screen/dth_recharge.dart';
import 'package:virzanpay/View/Screen/family_bonous_screen.dart';
import 'package:virzanpay/View/Screen/matching_%20bonous_screen.dart';
import 'package:virzanpay/View/Screen/mobile_recharge.dart';
import 'package:virzanpay/View/Screen/monthly_new_bonous_screen.dart';
import 'package:virzanpay/View/Screen/performance_bonous_screen.dart';
import 'package:virzanpay/View/Screen/recharge_commision_screen.dart';
import 'package:virzanpay/View/Screen/refer_earn_screen.dart';
import 'package:virzanpay/View/Screen/referal_bonous_screen.dart';
import 'package:virzanpay/View/Screen/transaction_history.dart';
import 'package:virzanpay/View/Screen/withdraw%20Setup/google_pey_setup.dart';
import 'package:virzanpay/View/Screen/withdrawHistory_screen.dart';
import 'package:virzanpay/View/auth/forget_password_screen.dart';
import 'package:virzanpay/View/auth/kyc_screen.dart';
import 'package:virzanpay/View/auth/password_setup_screen.dart';
import 'package:virzanpay/View/auth/sign-up.dart';
import 'package:virzanpay/View/auth/sign_in.dart';

import '../View/Screen/withdraw Setup/bank_account_setup.dart';
import '../View/Screen/withdraw Setup/paytm_setup.dart';
import '../View/Screen/withdraw Setup/phonepe_setup.dart';
import '../View/Screen/withdraw Setup/withdraw_setup.dart';

class MaterialRoute {
  static Map<String, WidgetBuilder> routes() {
    return {
      'sign-in-screen': (context) => SignInScreen(),
      'sign-up-screen': (context) => const SignUpScreen(),
      'navbar-screen': (context) => NavBarScreen(),
      'wallet-recharge-screen': (context) => const WalletRechargeScreen(),
      'transaction-history-screen': (context) => const TransactionHistory(),
      'kyc-screen': (context) => KYCScreen(),
      'dth-recharge-screen': (context) => const DthRecharge(),
      'instant-recharge-screen': (context) => const MobileRecharge(),
      'refer-earn-screen': (context) => const ReferEarnScreen(),
      'dth-history-screen': (context) => const DthHistory(),
      "recharge-selection-screen": (context) => const SelectionScreen(),
      "manually-recharge-screen": (context) => const AddManuallyBalance(),
      "performance-bonous-screen": (context) => const PerformanceBonousScreen(),
      "family-bonous-screen": (context) => const FamilyBonousScreen(),
      "matching-bonous-screen": (context) => const MatchingBonousScreen(),
      "upi-webview-screen": (context) => const UpiPayScreen(),
      "account-update-screen": (context) => const AccountUpdateScreen(),
      "googlepay-Setup-screen": (context) => const GooglepeySetup(),
      "phonepay-Setup-screen": (context) => const PhonepaySetup(),
      "bank-Setup-screen": (context) => const BankSetup(),
      "paytm-Setup-screen": (context) => const PaytmSetup(),
      "withdraw-setup-screen": (context) => const WithdrawSetupScreen(),
      "recharge-commission-screen": (context) =>
          const RechargeCommissionScreen(),
      "forget-password-screen": (context) => const ForgetPasswordScreen(),
      "forget-password-setup-screen": (context) => const PasswordSetupScreen(),
      "all-transaction-screen": (context) =>
          const AllTransactionHistroyScreen(),
      "deposit-history-screen": (context) => const DepositHistroyScreen(),
      "withdraw-history-screen": (context) => const WithdrawHistroyScreen(),
      // "withdraw-history-screen": (context) => const WithdrawHistroyScreen(),
      "refer-bonous-screen": (context) => const ReferalCommissionScreen(),
      "monthy-bonous-screen": (context) => const MonthlyNewBonuousScreen(),
    };
  }
}

class Routes {
  Routes._();
  static String signIn = 'sign-in-screen';
  static String signUp = 'sign-up-screen';
  static String NavScreen = 'navbar-screen';
  static String walletRecharge = 'wallet-recharge-screen';
  static String TranscationHistory = 'transaction-history-screen';
  static String kycScreen = 'kyc-screen';
  static String dthRechargeScreen = 'dth-recharge-screen';
  static String instantRechargeScreen = 'instant-recharge-screen';
  static String referEarnScreen = 'refer-earn-screen';
  static String dthHistoryScreen = 'dth-history-screen';
  static String rechargeSelection = "recharge-selection-screen";
  static String manuallyrechagreScreen = "manually-recharge-screen";
  static String performanceBonousScreen = "performance-bonous-screen";
  static String rechargeCommissionScreen = "recharge-commission-screen";
  static String upiWebviewScreen = "upi-webview-screen";
  static String accountUpdateScreen = "account-update-screen";
  static const String googlePaysetupScreen = "googlepay-Setup-screen";
  static const String phonePaysetupScreen = "phonepay-Setup-screen";
  static const String bankSetupScreen = "bank-Setup-screen";
  static const String paytmSetupScreen = "paytm-Setup-screen";
  static const String withdrawSetupScreen = "withdraw-setup-screen";
  static const String familybonousScreen = "family-bonous-screen";
  static const String matchingbonousScreen = "matching-bonous-screen";
  static const String forgetPasswordScreen = "forget-password-screen";
  static const String allTransactionScreen = "all-transaction-screen";
  static const String depositHistoryScreen = "deposit-history-screen";
  static const String withdrawHistoryScreen = "withdraw-history-screen";
  static const String referalCommissionScreen = "refer-bonous-screen";
  static const String monthlyCommissionScreen = "monthy-bonous-screen";
  static const String forgetPasswordSetupScreen =
      "forget-password-setup-screen";
  // static String upirechagreScreen = "Upi-recharge-screen";
}
