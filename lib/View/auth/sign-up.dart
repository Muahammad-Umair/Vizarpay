import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virzanpay/Model/auth.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/snackbar.dart';
import 'package:virzanpay/Utilies/Widget/textfield.dart';
import 'package:virzanpay/Utilies/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //inilize all the contoller
  late TextEditingController referalCodeC;
  late FocusNode referalFocus;
  late TextEditingController firstNameC;
  late FocusNode fnameFocus;
  late TextEditingController lastNameC;
  late FocusNode lnameFocus;
  late TextEditingController mobileNumberC;
  late FocusNode mobileFocus;
  late TextEditingController emailC;
  late FocusNode emailFocus;
  late TextEditingController otpController;
  late FocusNode otpFocus;
  late TextEditingController passwordController;
  late FocusNode paswordFocus;

  //register the controller
  @override
  void initState() {
    referalCodeC = TextEditingController();
    referalFocus = FocusNode();
    firstNameC = TextEditingController();
    fnameFocus = FocusNode();
    lastNameC = TextEditingController();
    lnameFocus = FocusNode();
    mobileNumberC = TextEditingController();
    mobileFocus = FocusNode();
    emailC = TextEditingController();
    emailFocus = FocusNode();
    otpController = TextEditingController();
    otpFocus = FocusNode();
    passwordController = TextEditingController();
    paswordFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    referalCodeC.dispose();
    referalFocus.dispose();
    firstNameC.dispose();
    fnameFocus.dispose();
    lastNameC.dispose();
    lnameFocus.dispose();
    emailC.dispose();
    emailFocus.dispose();

    otpController.dispose();
    otpFocus.dispose();
    passwordController.dispose();
    paswordFocus.dispose();

    super.dispose();
  }

  bool agree = false;
  bool hideText = false;
  bool isloading = false;
  Future<void> termlunch() async {
    final url = Uri.parse("https://mscpay.indiaonlinesolution.com");
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw "Cannot lunch at this time";
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: Colors.blueAccent.shade100,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(bottom: 16),
                  child: Text(
                    'Register to your Virzanpay account',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        controller: referalCodeC,
                        focusNode: referalFocus,
                        textInputAction: TextInputAction.next,
                        onfieldSubmit: (_) {
                          FocusScope.of(context).requestFocus(fnameFocus);
                        },
                        labelText: "Referal code(optional)",
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
                      child: CustomTextField(
                        controller: firstNameC,
                        focusNode: fnameFocus,
                        textInputAction: TextInputAction.next,
                        onfieldSubmit: (_) {
                          FocusScope.of(context).requestFocus(lnameFocus);
                        },
                        labelText: "First name",
                        valid: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First name should not be empty';
                          } else {
                            return null;
                          }
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
                      child: CustomTextField(
                        controller: lastNameC,
                        focusNode: lnameFocus,
                        textInputAction: TextInputAction.next,
                        onfieldSubmit: (_) {
                          FocusScope.of(context).requestFocus(mobileFocus);
                        },
                        labelText: "Last name",
                        valid: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last name should not be empty';
                          } else {
                            return null;
                          }
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
                      child: CustomTextField(
                        controller: mobileNumberC,
                        focusNode: mobileFocus,
                        textInputAction: TextInputAction.next,
                        onfieldSubmit: (_) {
                          FocusScope.of(context).requestFocus(emailFocus);
                        },
                        labelText: "Mobile number",
                        valid: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mobile number should not be empty';
                          } else {
                            return null;
                          }
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
                      child: CustomTextField(
                        controller: emailC,
                        focusNode: emailFocus,
                        textInputAction: TextInputAction.next,
                        onfieldSubmit: (_) {
                          FocusScope.of(context).requestFocus(paswordFocus);
                        },
                        labelText: "Email ID",
                        valid: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email name should not be empty';
                          } else if (!value.contains("@")) {
                            return "Email should be valid";
                          } else {
                            return null;
                          }
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
                      child: CustomTextField(
                        controller: passwordController,
                        focusNode: paswordFocus,
                        textInputAction: TextInputAction.done,
                        labelText: "Password",
                        hideText: hideText,
                        valid: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password should not be empty";
                          } else if (value.length < 8) {
                            return "Password should be at least 8 character long";
                          } else
                            return null;
                        },
                        trailing: IconButton(
                          icon: Icon(
                            hideText
                                ? Icons.visibility_off_rounded
                                : Icons.visibility,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: () {
                            setState(() {
                              hideText = !hideText;
                            });
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: agree,
                            checkColor: Colors.black,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                agree = value!;
                              });
                            },
                          ),
                          Text.rich(
                            textAlign: TextAlign.start,
                            TextSpan(
                              text: 'I agree with ',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Terms of Service',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await termlunch();
                                        // code to open / launch terms of service link here
                                      }),
                                TextSpan(
                                  text: ' and ',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Privacy Policy',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.red,
                                            fontStyle: FontStyle.italic,
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            await termlunch();
                                            // code to open / launch privacy policy link here
                                          })
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Align(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: size.width,
                        height: size.height * 0.065,
                        child: ElevatedButton.icon(
                          onPressed: !agree
                              ? () {
                                  showSnackBar(
                                      context: context,
                                      message:
                                          "Must be agree with our terms and conditions",
                                      error: true);
                                }
                              : isloading
                                  ? () {}
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isloading = true;
                                        });

                                        bool status = await Auth.signUp(
                                            referalCode: referalCodeC.text,
                                            fname: firstNameC.text,
                                            lname: lastNameC.text,
                                            phone: mobileNumberC.text,
                                            password: passwordController.text,
                                            email: emailC.text,
                                            context: context);
                                        setState(() {
                                          isloading = false;
                                        });
                                        if (status) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => Customdialog3(
                                              otpController: otpController,
                                            ),
                                          );
                                        }

                                        setState(() {
                                          isloading = false;
                                        });
                                      }
                                    },
                          icon: Row(
                            children: [
                              isloading
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
                              const Icon(Icons.lock_outline),
                            ],
                          ),
                          label: Text(
                            'SIGNUP SECURELY',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Already have Virzanpay account?',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                // padding: EdgeInsets.zero,

                                ),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.signIn, (route) => false);
                            },
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.lato(
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Customdialog3 extends StatefulWidget {
  late TextEditingController otpController;
  Customdialog3({super.key, required this.otpController});

  @override
  State<Customdialog3> createState() => _Customdialog3State();
}

class _Customdialog3State extends State<Customdialog3> {
  bool loading = false;
  bool loadingsubmitbutton = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        // height: size.height * 0.35/,
        width: size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verification code",
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                "Kindly enter the one time verification code recieved in your sms",
                style: GoogleFonts.notoSans(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verification code",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: CustomTextField(
                        controller: widget.otpController,
                        labelText: "",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });

                            bool result =
                                await Auth.resendOtp(context: context);

                            if (result) {
                              setState(() {
                                loading = false;
                              });
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Row(
                            children: [
                              loading
                                  ? const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 2),
                                      child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    ),
                              Text(
                                'Resend Otp',
                                style: GoogleFonts.lato(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.lato(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loadingsubmitbutton = true;
                          });
                          bool result = await Auth.verifyOtp(
                            otp: widget.otpController.text,
                            context: context,
                          );

                          if (result) {
                            setState(() {
                              loadingsubmitbutton = false;
                            });
                            await ApiService.checkbalance(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.kycScreen, (route) => false);
                          }
                          setState(() {
                            loadingsubmitbutton = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loadingsubmitbutton
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
                            Text(
                              "Submit",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
