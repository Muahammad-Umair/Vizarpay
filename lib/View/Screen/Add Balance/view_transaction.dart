// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:mscpay/Controller/balance_controller.dart';
// import 'package:mscpay/Controller/upi_transaction_controller.dart';
// import 'package:mscpay/Model/service.dart';
// import 'package:mscpay/Utilies/color.dart';
// import 'package:mscpay/generated/assets.dart';
// import 'package:provider/provider.dart';
//
// import '../../../Utilies/Widget/appbar.dart';
//
// class UpiTransactionHistoryScreen extends StatefulWidget {
//   const UpiTransactionHistoryScreen({super.key});
//
//   @override
//   State<UpiTransactionHistoryScreen> createState() =>
//       _UpiTransactionHistoryScreenState();
// }
//
// class _UpiTransactionHistoryScreenState
//     extends State<UpiTransactionHistoryScreen> {
//   // @override
//   // bool loading = false;
//   // List<bool> loadingStates = [];
//   // loadingStates = List.generate(.length, (index) => false);
//   // List<UpiTransaction> transactionlist = [];
//   //
//   // bool isFirstTime = true;
//   // @override
//   // void didChangeDependencies() {
//   //
//   //
//   //   if (isFirstTime) {
//   //     transactionlist =
//   //         context.watch<UpiTransactionContoller>().transactionList;
//   //
//   //   }
//   //   isFirstTime = false;
//   //   super.didChangeDependencies();
//   // }
//
//   // List.generate(transactionlist.length, (index) => false);
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: CustomAppBar(
//           title: "Transaction History",
//           centerTitle: true,
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await Provider.of<UpiTransactionContoller>(context)
//               .fetchupiHistory(context);
//           await ApiService.checkbalance(context);
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               FutureBuilder<void>(
//                 future: fetchData(context),
//                 builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return buildLoadingWidget();
//                   } else if (snapshot.hasError) {
//                     return buildErrorWidget(snapshot.error, context);
//                   } else {
//                     return buildDataWidget(context);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> fetchData(BuildContext context) async {
//     final controller = Provider.of<UpiTransactionContoller>(
//       context,
//       listen: false,
//     );
//     await controller.fetchupiHistory(context);
//   }
//
//   Widget buildLoadingWidget() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//               ),
//             ),
//             width: double.infinity,
//             child: Center(
//               child: Text(
//                 "TRANSACTION HISTORY'S",
//                 style: GoogleFonts.lato(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           const SizedBox(height: 40),
//           const Center(child: CircularProgressIndicator()),
//           const SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
//
//   Widget buildErrorWidget(dynamic error, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//               ),
//             ),
//             width: double.infinity,
//             child: Center(
//               child: Text(
//                 "TRANSACTION HISTORY'S",
//                 style: GoogleFonts.lato(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 5),
//           const SizedBox(height: 5),
//           Container(
//             height: MediaQuery.of(context).size.height * 0.4,
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(Assets.imagesNoData),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           Text(
//             "Error: $error",
//             style: GoogleFonts.lato(
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 5),
//         ],
//       ),
//     );
//   }
//
//   Widget buildDataWidget(BuildContext context) {
//     // final controller =
//     //     Provider.of<UpiTransactionContoller>(context, listen: false);
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: 10,
//             ),
//             decoration: BoxDecoration(
//               // color: Materialcolor.thirdColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//               ),
//             ),
//             width: double.infinity,
//             child: Center(
//               child: Text(
//                 "TRANSACTION HISTORY'S",
//                 style: GoogleFonts.lato(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: controller.transactionList.isEmpty ? 0 : 5),
//           Container(
//             color: Colors.white,
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: SingleChildScrollView(
//               child: Column(
//                   children: controller.transactionList.isEmpty
//                       ? [
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.3,
//                             width: MediaQuery.of(context).size.width,
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage(Assets.imagesNoData),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             "No data found",
//                             style: GoogleFonts.lato(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 22,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ]
//                       : controller.transactionList.map((tx) {
//                           final utcDate = DateTime.parse(tx.createDate).toUtc();
//                           final formatDate =
//                               DateFormat('dd-MM-yyyy').format(utcDate);
//
//                           return Container(
//                             height: 100,
//                             width: double.infinity,
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 2),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 const BoxShadow(
//                                     color: Colors.black12,
//                                     offset: Offset(-1, -1)),
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   offset: const Offset(1, 1),
//                                 ),
//                               ],
//                             ),
//                             child: Center(
//                               child: ListTile(
//                                 title: Padding(
//                                   padding: const EdgeInsets.only(bottom: 10.0),
//                                   child: Text(
//                                     "Tx-id: ${tx.transactionId}",
//                                     style: GoogleFonts.lato(
//                                       color: Colors.black,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 trailing: FittedBox(
//                                   child: ElevatedButton(
//                                     onPressed: tx.transactionStatus ==
//                                                 'scanning' ||
//                                             tx.transactionStatus == 'created'
//                                         ? () async {
//                                             final a =
//                                                 await controller.checkStauts(
//                                               context: context,
//                                               txid: tx.transactionId,
//                                               date: formatDate,
//                                             );
//                                             if (a) {
//                                               setState(() {
//                                                 // loadingStates[index] = false;
//                                               });
//                                               await controller
//                                                   .fetchupiHistory(context);
//                                               await ApiService.checkbalance(
//                                                   context);
//                                             } else {
//                                               setState(() {});
//                                             }
//                                           }
//                                         : () {},
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: tx.transactionStatus ==
//                                                   'scanning' ||
//                                               tx.transactionStatus == 'created'
//                                           ? Colors.green
//                                           : Colors.red,
//                                     ),
//                                     child: Text(tx.transactionStatus),
//                                   ),
//                                 ),
//                                 subtitle: Text(formatDate),
//                               ),
//                             ),
//                           );
//                         }).toList()),
//             ),
//           ),
//           //                 ]  :
//         ],
//       ),
//     );
//   }
// }
