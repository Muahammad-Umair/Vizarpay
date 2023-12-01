import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/dthHistoty_controller.dart';
import 'package:virzanpay/Model/dthHistory.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/generated/assets.dart';

class DthHistory extends StatefulWidget {
  const DthHistory({super.key});

  @override
  State<DthHistory> createState() => _DthHistoryState();
}

class _DthHistoryState extends State<DthHistory> {
  List<Dth> dthHistorylist = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dthHistorylist = context.watch<DthController>().transactionList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: "History",
          centerTitle: false,
          backbutton: true,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ApiService.TransactionHistory(context);
          await ApiService.checkbalance(context);
        },
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 6),
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
                  "Recharge History",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: dthHistorylist.isEmpty ? size.height * 0.04 : 4,
            ),
            dthHistorylist.isEmpty
                ? Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: size.height * 0.35,
                          width: size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage(
                                Assets.imagesNoData,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "No data found",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black),
                      ),
                    ],
                  )
                : Container(
                    child: Expanded(
                    child: ListView.builder(
                      itemCount: dthHistorylist.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        Dth transaction = dthHistorylist[index];
                        return Container(
                          // height: 80,
                          width: size.width,
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: transaction.status == "SUCCESS" ||
                                    transaction.status == "success"
                                ? Color(0xFF98E0FF)
                                : transaction.status == "PENDING" ||
                                        transaction.status == "pending"
                                    ? Colors.yellow
                                    : Colors.red.shade400,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(-1, -1),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Center(
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  transaction.number,
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              trailing: FittedBox(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: Row(
                                    children: [
                                      Text(transaction.amount),
                                    ],
                                  ),
                                ),
                              ),
                              subtitle: Text(transaction.status),
                            ),
                          ),
                        );
                      },
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
