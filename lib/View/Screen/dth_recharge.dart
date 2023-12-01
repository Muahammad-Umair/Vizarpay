import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/Widget/snackbar.dart';
import 'package:virzanpay/Utilies/Widget/textfield.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';

class DthRecharge extends StatefulWidget {
  const DthRecharge({super.key});

  @override
  State<DthRecharge> createState() => _DthRechargeState();
}

class _DthRechargeState extends State<DthRecharge> {
  late TextEditingController amountC;
  late FocusNode amountFocus;
  late TextEditingController mobileC;
  late FocusNode mobileFocus;
  // late TextEditingController alertNC;
  late FocusNode alertFocus;
  // late TextEditingController type;

  @override
  void initState() {
    amountC = TextEditingController();
    amountFocus = FocusNode();
    mobileC = TextEditingController();
    mobileFocus = FocusNode();
    // alertNC = TextEditingController();
    alertFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    amountC.dispose();
    amountFocus.dispose();
    mobileC.dispose();
    mobileFocus.dispose();
    // alertNC.dispose();
    alertFocus.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  bool loading2 = false;

  List<String> dthRechargeName = [
    "Select value",
    "Airtel_DigitalTv",
    "DishTv",
    "SunDirect",
    "TataSky",
    "VideoconD2h",
  ];

  Map<String, String> operatorCodeMap = {
    "Airtel_DigitalTv": "51",
    "DishTv": "53",
    "SunDirect": "54",
    "TataSky": "55",
    "VideoconD2h": "56"
  };

  String Operator = "Select value";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: "Dth Recharge",
          centerTitle: false,
          backbutton: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomTextField(
                          controller: mobileC,
                          labelText: "Mobile Number",
                          valid: (value) {
                            if (value == null || value.isEmpty) {
                              return "Mobile number should not be empty";
                            }
                            return null;
                          },
                          keyboadType: TextInputType.number,
                          focusNode: mobileFocus,
                          textInputAction: TextInputAction.next,
                          onfieldSubmit: (_) {
                            FocusScope.of(context).requestFocus(alertFocus);
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * (0.01),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomTextField(
                          controller: amountC,
                          keyboadType: TextInputType.number,
                          focusNode: amountFocus,
                          textInputAction: TextInputAction.next,
                          labelText: "Amount",
                          valid: (value) {
                            if (value == null || value.isEmpty) {
                              return "Amount should not be empty";
                            } else if (int.parse(value) < 10) {
                              return "Amount should not be less than 10";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: DropdownButton<String>(
                          value: Operator,
                          onChanged: (value) {
                            setState(() {
                              Operator = value!;
                            });
                          },
                          isExpanded: true,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                          ),
                          items: dthRechargeName
                              .map((rechargeName) => DropdownMenuItem<String>(
                                    value: rechargeName,
                                    child: Text(rechargeName),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.23,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10).copyWith(bottom: 4),
            child: SizedBox(
              height: size.height * 0.06,
              width: size.width,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading2 = true;
                  });
                  bool status = await ApiService.DthTHistory(context);

                  setState(() {
                    loading2 = false;
                  });
                  if (status) {
                    Navigator.pushNamed(context, Routes.dthHistoryScreen);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading2
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10)
                                .copyWith(left: 0, right: 10),
                            child: const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Dth Recharge History',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // padding: EdgeInsets.symmetric(horizontal: 32.0),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: size.height * 0.06,
              width: size.width,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    if (Operator == "Select value") {
                      showSnackBar(
                          context: context,
                          message: "Select an Operator",
                          error: true);
                      return;
                    } else {
                      setState(() {
                        loading = true;
                      });

                      bool result = await ApiService.dthRecharge(
                        context: context,
                        number: mobileC.text,
                        // alertN: alertNC.text,
                        amount: amountC.text,
                        operator: operatorCodeMap[Operator] ?? '',
                      );

                      setState(() {
                        loading = false;
                      });
                      if (result) {
                        await ApiService.checkbalance(context);
                      }
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10)
                                .copyWith(left: 0, right: 10),
                            child: const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Recharge Now',
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Color(0xFFC62828),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // padding: EdgeInsets.symmetric(horizontal: 32.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
