import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/transactonContoller.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Model/transaction.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/generated/assets.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  bool loading = false;
  List<bool> loadingStates = [];
  List<Transaction> transactionlist = [];

  bool isFirstTime = true;
  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      transactionlist = context.watch<TransactionContoller>().transactionList;
      loadingStates = List.generate(transactionlist.length, (index) => false);
    }
    isFirstTime = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: "Transaction History",
          centerTitle: false,
          backbutton: true,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ApiService.TransactionHistory(context);
          await ApiService.checkbalance(context);
          isFirstTime = true;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                margin: const EdgeInsets.all(4),
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
                    "Transaction History",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              transactionlist.isEmpty
                  ? Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: size.height * 0.35,
                            width: size.width,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
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
                        itemCount: transactionlist.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          Transaction transaction = transactionlist[index];

                          final utcDate =
                              DateTime.parse(transaction.createDate).toUtc();
                          final formatDate =
                              DateFormat('dd-MM-yyyy').format(utcDate);
                          print(
                              "here is date +++++++++++++++++++++++++++${formatDate}");
                          return Container(
                            height: 100,
                            width: size.width,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF98E0FF),
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
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "Tx-id: " + transaction.transactionId,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                trailing: FittedBox(
                                  child: ElevatedButton(
                                    onPressed: transaction.transactionStatus ==
                                                'scanning' ||
                                            transaction.transactionStatus ==
                                                'created'
                                        ? () async {
                                            setState(() {
                                              loadingStates[index] = true;
                                            });
                                            final a =
                                                await ApiService.checkStauts(
                                                    context: context,
                                                    txid: transaction
                                                        .transactionId,
                                                    date: formatDate);
                                            if (a) {
                                              setState(() {
                                                loadingStates[index] = false;
                                              });
                                              await ApiService
                                                  .TransactionHistory(context);
                                              await ApiService.checkbalance(
                                                  context);
                                              isFirstTime = true;
                                            }
                                            setState(() {
                                              loadingStates[index] = false;
                                            });
                                          }
                                        : () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: transaction
                                                      .transactionStatus ==
                                                  'scanning' ||
                                              transaction.transactionStatus ==
                                                  'created'
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    child: Row(
                                      children: [
                                        loadingStates[index]
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 10.0,
                                                            vertical: 10)
                                                        .copyWith(
                                                            left: 0, right: 10),
                                                child: const SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(height: 0),
                                        Text(transaction.transactionStatus),
                                      ],
                                    ),
                                  ),
                                ),
                                subtitle: Text(formatDate),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
