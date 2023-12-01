import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/kyc_check_controller.dart';
import 'package:virzanpay/Utilies/Widget/custom_drawer.dart';
import 'package:virzanpay/Utilies/Widget/snackbar.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';
import 'package:virzanpay/generated/assets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kycController = context.read<KycController>();
    print(
        "Here is the response in first page ${kycController.kycStatus} +++++++++++++++++++++++++++++++++");
    String image = sharedPreferences.getString('image') ?? '';
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.4,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.25,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.1,
                child: Center(
                  child: Container(
                    height: size.height / 3.8,
                    width: size.width - 80,
                    margin: EdgeInsets.symmetric(horizontal: size.width / 9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height / 80),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: image.isNotEmpty
                              ? CachedNetworkImageProvider(
                                  image,
                                ) as ImageProvider
                              : const AssetImage(Assets.imagesProfileImage),
                        ),
                        SizedBox(height: size.height / 200),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              sharedPreferences.getString('fname') ?? '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: FutureBuilder(
                                future: kycController.checkKycVerification(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Icon(
                                      Icons.verified,
                                      color: kycController.kycStatus == 'Yes'
                                          ? Colors.blue
                                          : Colors.grey,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height / 150),
                        Text(
                          sharedPreferences.getString('phone') ?? '',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: size.height / 60),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Customlisttile2(
                    icon: const Icon(Icons.wallet_outlined),
                    tap: () {
                      Navigator.of(context).pushNamed(Routes.walletRecharge);
                    },
                    title: "ADD MONEY"),
                Consumer<KycController>(builder: (context, controller, __) {
                  return Customlisttile2(
                      icon: Icon(
                        Icons.verified,
                        color: controller.kycStatus == 'Yes'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      tap: controller.kycStatus == 'Yes'
                          ? () {
                              showSnackBar(
                                  context: context,
                                  message: "Already verified");
                            }
                          : controller.kycStatus == 'Pending'
                              ? () {
                                  showSnackBar(
                                      context: context, message: "Pending!");
                                }
                              : () {
                                  Navigator.of(context).pushNamed(
                                      Routes.kycScreen,
                                      arguments: true);
                                },
                      title: "KYC VALIDATIONS");
                }),
                Customlisttile2(
                  icon: const Icon(Icons.edit),
                  tap: () {
                    Navigator.of(context).pushNamed(Routes.accountUpdateScreen);
                  },
                  title: "UPDATE ACCCOUNT",
                ),
                Customlisttile2(
                  icon: const Icon(Icons.arrow_upward),
                  title: "WITHDRAW SETUP",
                  tap: () {
                    Navigator.of(context).pushNamed(Routes.withdrawSetupScreen);
                  },
                ),
                Customlisttile2(
                  icon: const Icon(Icons.history_outlined),
                  title: "ALL TRANSACTIONS",
                  tap: () {
                    Navigator.pushNamed(context, Routes.allTransactionScreen);
                  },
                ),
                Customlisttile2(
                  icon: const Icon(Icons.sync_alt),
                  title: "DEPOSIT HISTORY",
                  tap: () {
                    Navigator.pushNamed(context, Routes.depositHistoryScreen);
                  },
                ),
                Customlisttile2(
                  icon: const Icon(
                    Icons.history_outlined,
                  ),
                  title: "WITHDRAW HISTORY",
                  tap: () {
                    Navigator.pushNamed(context, Routes.withdrawHistoryScreen);
                  },
                ),
                Customlisttile2(
                    icon: const Icon(Icons.logout),
                    tap: () async {
                      await sharedPreferences.clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.signIn, (route) => false);
                    },
                    title: "LOGOUT")
              ],
            ),
          ),
        )
      ],
    );
  }
}
