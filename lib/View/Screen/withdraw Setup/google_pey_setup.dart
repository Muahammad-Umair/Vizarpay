import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/Widget/button.dart';
import 'package:virzanpay/Utilies/Widget/textfield.dart';
import 'package:virzanpay/Utilies/constant.dart';

class GooglepeySetup extends StatefulWidget {
  const GooglepeySetup({super.key});

  @override
  State<GooglepeySetup> createState() => _GooglepeySetupState();
}

class _GooglepeySetupState extends State<GooglepeySetup> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
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
          title: "Google pey",
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
                    controller: controller,
                    labelTextfontSize: 12,
                    labelText: "Enter your account number",
                    valid: (value) {
                      if (value.toString().isEmpty) {
                        return "Account number should not be empty";
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
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
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
                bhimAddress: controller.text,
              );
              if (result) {
                controller.clear();
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
