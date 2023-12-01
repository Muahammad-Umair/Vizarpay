import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/Widget/textfield.dart';
import 'package:virzanpay/Utilies/constant.dart';

class AddManuallyBalance extends StatefulWidget {
  const AddManuallyBalance({super.key});

  @override
  State<AddManuallyBalance> createState() => _AddManuallyBalanceState();
}

class _AddManuallyBalanceState extends State<AddManuallyBalance> {
  late final TextEditingController amountC;
  late final TextEditingController transectionIdC;

  @override
  void initState() {
    amountC = TextEditingController();
    transectionIdC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    amountC.dispose();
    transectionIdC.dispose();
    super.dispose();
  }

  // here is list of transaction method we are used
  final List<String> transactionMethod = const [
    "Bank Transfer",
    "GPay",
    "PhonePe",
    "Paytm",
    "UPI",
  ];
  // selected payment method
  String selected = "Bank Transfer";

  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          centerTitle: true,
          backbutton: true,
          title: "Add Manually",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 2,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10)),
                        child: CustomTextField(
                          controller: amountC,
                          labelTextfontSize: 12,
                          labelText: "Amount",
                          valid: (value) {
                            if (value.toString().isEmpty) {
                              return "Amount should not empty";
                            } else if (int.parse(value.toString()) < 10) {
                              return "Amount should not be less than 10";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 2,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10)),
                        child: CustomTextField(
                          controller: transectionIdC,
                          labelText: 'Transacton ID',
                          valid: (value) {
                            if (value.toString().isEmpty) {
                              return "Transaction id should not empty";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Transaction By",
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              // color: textfieldlabelColor,
                              fontSize: labelfontSize,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: transactionMethod
                            .map((transaction) => RadioListTile(
                                  value: transaction,
                                  // activeColor: Materialcolor.buttonColor,
                                  title: Text(transaction),
                                  groupValue: selected,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 0),
                                  onChanged: (value) {
                                    setState(() {
                                      selected = value.toString();
                                    });
                                  },
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
              SlideInUp(
                  child: SizedBox(
                width: size.width,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      bool status = await ApiService.addManuallyamount(
                          transactionId: transectionIdC.text,
                          amount: amountC.text,
                          mode: selected,
                          context: context);
                      await ApiService.checkbalance(context);
                      setState(() {
                        loading = false;
                      });
                      if (status) {
                        amountC.clear();
                        transectionIdC.clear();
                        FocusScope.of(context).unfocus();
                      } else {
                        FocusScope.of(context).unfocus();
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loading
                          ? const SizedBox(
                              height: 27,
                              width: 27,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "SUBMIT",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
