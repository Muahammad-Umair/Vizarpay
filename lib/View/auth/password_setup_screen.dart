import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virzanpay/Model/auth.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/Widget/button.dart';
import 'package:virzanpay/Utilies/Widget/textfield.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';

class PasswordSetupScreen extends StatefulWidget {
  const PasswordSetupScreen({super.key});

  @override
  State<PasswordSetupScreen> createState() => _PasswordSetupScreenState();
}

class _PasswordSetupScreenState extends State<PasswordSetupScreen> {
  late TextEditingController otpController;
  late TextEditingController passwordController;
  late TextEditingController confirmpasswordController;

  @override
  void initState() {
    otpController = TextEditingController();
    passwordController = TextEditingController();
    confirmpasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final phone = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: "Password Setup",
          backbutton: true,
          trailing: [
            const SizedBox(),
          ],
          centerTitle: false,
        ),
      ),
      body: Form(
        key: _formKey,
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
                        height: size.height * 0.02,
                      ),
                      SlideInLeft(
                        child: Text(
                          "Otp Number",
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: labelfontSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.003,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300,
                        ),
                        child: SlideInLeft(
                          child: CustomTextField(
                            controller: otpController,
                            labelText: "Enter your otp number",
                            valid: (value) {
                              if (value!.isEmpty) {
                                return "Otp number must not be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SlideInLeft(
                        child: Text(
                          "Password",
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: labelfontSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.003,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300,
                        ),
                        child: SlideInLeft(
                          child: CustomTextField(
                            controller: passwordController,
                            labelText: "Enter your password",
                            valid: (value) {
                              if (value!.isEmpty) {
                                return "password must not be empty";
                              } else if (value.length < 8) {
                                return "password must not be less than 8";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SlideInLeft(
                        child: Text(
                          "Confirm Password",
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: labelfontSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.003,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300,
                        ),
                        child: SlideInLeft(
                          child: CustomTextField(
                            controller: confirmpasswordController,
                            labelText: "Enter your confirm password",
                            valid: (value) {
                              if (value!.isEmpty) {
                                return "confirm password must not be empty";
                              } else if (value != passwordController.text) {
                                return "Password should be matched";
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
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      bool status = await Auth.resetupdatePassword(
                          otp: otpController.text,
                          password: passwordController.text,
                          phone: phone.toString(),
                          context: context);
                      loading = false;

                      if (status) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.signIn, (route) => false);
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
