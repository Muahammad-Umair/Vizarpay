import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/Widget/button.dart';
import 'package:virzanpay/Utilies/Widget/textfield.dart';
import 'package:virzanpay/Utilies/constant.dart';

class BankSetup extends StatefulWidget {
  const BankSetup({super.key});

  @override
  State<BankSetup> createState() => _BankSetupState();
}

class _BankSetupState extends State<BankSetup> {
  late TextEditingController nameController;
  late FocusNode nameFocus;
  late TextEditingController accountnoController;
  late FocusNode accountFocus;
  late TextEditingController ifscCodeController;
  late FocusNode ifscFocus;

  @override
  void initState() {
    nameController = TextEditingController();
    nameFocus = FocusNode();
    accountnoController = TextEditingController();
    accountFocus = FocusNode();
    ifscCodeController = TextEditingController();
    ifscFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFocus.dispose();
    accountnoController.dispose();
    accountFocus.dispose();
    ifscCodeController.dispose();
    ifscFocus.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: "Bank Account",
          backbutton: true,
          centerTitle: false,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Text(
                  "Account Holder Name",
                  style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: labelfontSize,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.004,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomTextField(
                    controller: nameController,
                    labelText: "Enter account holder name",
                    labelTextfontSize: 12,
                    focusNode: nameFocus,
                    textInputAction: TextInputAction.next,
                    onfieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(accountFocus);
                    },
                    valid: (value) {
                      if (value.toString().isEmpty) {
                        return "Name should not be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Text(
                  "Account Number",
                  style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: labelfontSize,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.004,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomTextField(
                    controller: accountnoController,
                    focusNode: accountFocus,
                    textInputAction: TextInputAction.next,
                    onfieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(ifscFocus);
                    },
                    labelText: "Enter account number",
                    valid: (value) {
                      if (value.toString().isEmpty) {
                        return "Account number should not be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Text(
                  "IFSc code",
                  style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: textfieldlabelColor,
                      fontSize: labelfontSize,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.004,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomTextField(
                    controller: ifscCodeController,
                    focusNode: ifscFocus,
                    textInputAction: TextInputAction.done,
                    labelText: "Enter IFSc code",
                    valid: (value) {
                      if (value.toString().isEmpty) {
                        return "IFsc code should not be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: CustomButton(
          widget: Row(
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
                width: 5,
              ),
              Text(
                "Submit",
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          color: Colors.blueAccent,
          ontap: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                loading = true;
              });
              bool result = await ApiService.updateWithdraw(
                context: context,
                beneficiaryName: nameController.text,
                bankAccountNo: accountnoController.text,
                bankIfscCode: ifscCodeController.text,
              );

              if (result) {
                nameController.clear();
                accountnoController.clear();
                ifscCodeController.clear();
              }
              setState(() {
                loading = false;
              });
            }
          },
        ),
      ),
    );
  }
}
