import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/monthly_bonous_controller.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/generated/assets.dart';

class MonthlyNewBonuousScreen extends StatelessWidget {
  const MonthlyNewBonuousScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: "Monthly Bonous",
          backbutton: true,
          centerTitle: false,
          trailing: [
            const SizedBox(),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                height: 40,
                alignment: Alignment.center,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Consumer<MonthlyBonousController>(
                    builder: (context, controller, _) {
                  return Text("INR: ${controller.monthlybalance}");
                }))),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Monthly Bonous & History",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Month',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Match',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Credit',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Debit',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Balance',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TodayRecharge(),
                    const SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 12, horizontal: 10),
                    //   margin: EdgeInsets.all(10),
                    //   decoration: const BoxDecoration(
                    //     color: Colors.blueAccent,
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(15),
                    //       topRight: Radius.circular(15),
                    //     ),
                    //   ),
                    //   width: double.infinity,
                    //   child: Center(
                    //     child: Text(
                    //       "Payout History",
                    //       style: GoogleFonts.lato(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodayRecharge extends StatelessWidget {
  const TodayRecharge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<MonthlyBonousController>(context)
            .checkMonthlybalance();
        await Provider.of<MonthlyBonousController>(context)
            .checkMonthlyBonousHistory();
      },
      child: FutureBuilder<void>(
        future: fetchData(context),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingWidget();
          } else if (snapshot.hasError) {
            return buildErrorWidget(snapshot.error, context);
          } else {
            return buildDataWidget(context);
          }
        },
      ),
    );
  }

  Future<void> fetchData(BuildContext context) async {
    final controller = Provider.of<MonthlyBonousController>(
      context,
      listen: false,
    );
    await controller.checkMonthlybalance();
    await controller.checkMonthlyBonousHistory();
  }

  Widget buildLoadingWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          SizedBox(height: 40),
          Center(
              child: CircularProgressIndicator(
            color: Colors.blueAccent,
          )),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildErrorWidget(dynamic error, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesNoData),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            "Error: $error",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildDataWidget(BuildContext context) {
    final list = Provider.of<MonthlyBonousController>(
      context,
    ).monthlyBonouslist;
    return Container(
      margin: const EdgeInsets.all(10).copyWith(right: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: list.isEmpty
                ? [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.imagesNoData),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      "No data found",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ]
                : list.map(
                    (monthlyCommission) {
                      return FlipInX(
                        duration: const Duration(seconds: 2),
                        child: Container(
                          // margin: EdgeInsets.all(6),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(10),
                            //   topRight: Radius.circular(10),
                            // ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(-1, -1)),
                              BoxShadow(
                                  color: Colors.black12, offset: Offset(1, 1)),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Expanded(
                              //   flex: 1,
                              //   child: Column(
                              //     children: [
                              //       Text(
                              //         rechargeCommission.month.toString(),
                              //         textAlign: TextAlign.center,
                              //         style: GoogleFonts.cairo(
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //       Text(
                              //         rechargeCommission.time.toString(),
                              //         textAlign: TextAlign.center,
                              //         style: GoogleFonts.cairo(
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${monthlyCommission.month}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${monthlyCommission.match}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Text(
                                  "+${monthlyCommission.credit}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "-${monthlyCommission.debit}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  monthlyCommission.balance.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
          ),
        ),
      ),
    );
  }
}
