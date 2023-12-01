import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/history_controller.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/generated/assets.dart';

class WithdrawHistroyScreen extends StatelessWidget {
  const WithdrawHistroyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: 'Withdraw History',
          centerTitle: false,
          backbutton: true,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
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
                "WITHDRAW TRANSACTION'S",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Trans',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Amount',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Mode',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Status',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }

  Future<void> fetchData(BuildContext context) async {
    final controller = Provider.of<WithdrawHistoryC>(
      context,
      listen: false,
    );
    await controller.fetchTransaction();
  }

  Widget buildLoadingWidget() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 40),
          Center(child: CircularProgressIndicator()),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildErrorWidget(dynamic error, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
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
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildDataWidget(BuildContext context) {
    final withdrawHistoryC = Provider.of<WithdrawHistoryC>(
      context,
      listen: false,
    );

    return Container(
      margin: const EdgeInsets.all(6).copyWith(right: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: withdrawHistoryC.transaction.isEmpty
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
                ]
              : withdrawHistoryC.transaction
                  .map(
                    (withdrawHistory) => FlipInX(
                      duration: const Duration(seconds: 2),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12, offset: Offset(-1, -1)),
                            BoxShadow(
                                color: Colors.black12, offset: Offset(1, 1)),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                withdrawHistory.transaction,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                withdrawHistory.amount,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  withdrawHistory.mode,
                                  textAlign: TextAlign.center,
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  withdrawHistory.transactionStatus,
                                  textAlign: TextAlign.end,
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
