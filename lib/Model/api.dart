class Api {
  static const String baseApi = "https://mscpay.indiaonlinesolution.com/api/v1";
  static const String signinApi = "$baseApi/login";
  static const String signupApi = "$baseApi/register";
  static const String otpApi = "$baseApi/verify-register-otp";
  static const String verifyotp = "$baseApi/verify-otp";
  static const String resendotpApi = "$baseApi/resend-otp";
  static const String addUpiamountApi = "$baseApi/upi-create_order";
  static const String viewtransactionApi = "$baseApi/upi-get_transaction";
  static const String checkstatus = "$baseApi/upi-check_status";
  static const String checkBalance = "$baseApi/user_balance";
  static const String kycApi = "$baseApi/kyc";
  static const String dthrecharegeApi = "$baseApi/dth_recharge";
  static const String dthHistory = "$baseApi/dth_recharge_history";
  static const String manuallyPayment = "$baseApi/deposit_request";
  static const String premiumPrice = "$baseApi/get-premium-amount";
  static const String ispremium = "$baseApi/check_is_premium";
  static const String updateNameImage = '$baseApi/update-profile';
  // static const String updateNameImage = '$baseApi/profile_image';
  static const String updatePassword = '$baseApi/update/password';
  static const String rechargeCommisionBalance =
      "$baseApi/recharge_commissions_balance";

  static const String referralBonousBalance = '$baseApi/game_refer_reward';
  static const String monthlyBonousBalance = '$baseApi/new_monthly_bonus';
  static const String referralBonousHistory =
      '$baseApi/game_refer_reward_history';
  static const String monthlyBonousHistory =
      '$baseApi/new_monthly_bonus_history';

  static const String updatePaymentMethod = '$baseApi/add_payment_methods';
  static const String rechargeCommision = "$baseApi/recharge_commission";
  static const String matchingBonousBalance = "$baseApi/matching_bonus_balance";
  static const String matchingBonous = "$baseApi/matching_bonus";
  static const String familyBonousBalance = "$baseApi/family_bonus_balance";
  static const String familyBonous = "$baseApi/family_bonus";
  static const String slider = "$baseApi/slider_text_image";
  static const String resetupdatePassword = '$baseApi/forgot/update-password';
  static const String performanceBonousBalance =
      "$baseApi/performance_bonus_balance";
  static const String performanceBonous = "$baseApi/perfomance_bonus";
  static const String forgetpassword = "$baseApi/reset-password";
  static const String withdrawhistory = '$baseApi/user_withdraw_history';
  static const String deposithistory = '$baseApi/user_deposit_history';

  static const String referalDecision = "$baseApi/referral-decision";
  static const String referalUser = "$baseApi/referral-binary-users";
  static const String usertransaction = '$baseApi/user_transactions';
  static const String referalDecisionSubmit =
      "$baseApi/referral-decision-submit";

  static const String kycCheck = "$baseApi/kyc_is_verified";
}
