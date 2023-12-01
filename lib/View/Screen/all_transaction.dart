import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/history_controller.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/generated/assets.dart';

class AllTransactionHistroyScreen extends StatelessWidget {
  const AllTransactionHistroyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: 'Transaction History',
          backbutton: true,
          centerTitle: false,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<AllTransactionC>(
            context,
          ).fetchTransaction();
        },
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                  "TRANSACTION'S HISTORY",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Date',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Desc',
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
            FutureBuilder<void>(
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
          ],
        ),
      ),
    );
  }

  Future<void> fetchData(BuildContext context) async {
    final controller = Provider.of<AllTransactionC>(
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
          const SizedBox(height: 5),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesNoData),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Error: $error",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildDataWidget(BuildContext context) {
    final gamesController = Provider.of<AllTransactionC>(
      context,
      listen: false,
    );

    return Container(
      margin: const EdgeInsets.all(10).copyWith(right: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: gamesController.alltransaction.isEmpty
                ? [
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
                      "No data found",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ]
                : gamesController.alltransaction
                    .map(
                      (game) => FlipInX(
                        duration: const Duration(seconds: 2),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
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
                              Expanded(
                                flex: 1,
                                child: Text(
                                  game.createDate.isNotEmpty
                                      ? game.createDate.substring(0, 10)
                                      : game.createDate,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    game.descriptions,
                                    textAlign: TextAlign.center,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    game.credit,
                                    textAlign: TextAlign.center,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    game.debit,
                                    textAlign: TextAlign.center,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    game.balance,
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}
