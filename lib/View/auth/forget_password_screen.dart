import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virzanpay/Model/auth.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/Widget/button.dart';
import 'package:virzanpay/Utilies/Widget/textfield.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    _phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: "Password Reset",
          centerTitle: false,
          backbutton: true,
          trailing: [
            const SizedBox(),
          ],
        ),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      SlideInLeft(
                        child: Text(
                          "Phone Number",
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: labelfontSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.008,
                      ),
                      SlideInLeft(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300,
                          ),
                          child: CustomTextField(
                            controller: _phoneController,
                            labelText: "Enter your phone number",
                            valid: (value) {
                              if (value!.isEmpty) {
                                return "Phone number must not be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
              SlideInUp(
                child: CustomButton(
                  ontap: () async {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });

                      bool status = await Auth.resetPassword(
                          phoneNumber: _phoneController.text, context: context);
                      loading = false;
                      if (status) {
                        Navigator.pushNamed(
                            context, Routes.forgetPasswordSetupScreen,
                            arguments: _phoneController.text);
                      } else {
                        setState(() {
                          loading = false;
                        });
                      }
                    }
                  },
                  color: Colors.blueAccent,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
