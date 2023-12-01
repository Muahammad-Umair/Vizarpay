import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virzanpay/Model/auth.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/snackbar.dart';
import 'package:virzanpay/Utilies/Widget/textfield.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/Utilies/routes.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController phoneController;
  late FocusNode phoneFocus;

  late TextEditingController passwordController;
  late FocusNode passwordFocus;
  late TextEditingController otpController;
  @override
  void initState() {
    phoneController = TextEditingController();
    phoneFocus = FocusNode();
    passwordController = TextEditingController();
    passwordFocus = FocusNode();
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocus.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    otpController.dispose();
    super.dispose();
  }

  bool hideText = true;
  bool isloading = false;
  bool loading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      body: Column(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Login to your Virzanpay account',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.06,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomTextField(
                                controller: phoneController,
                                labelText: "Mobile number",
                                valid: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Mobile number should not be empty";
                                  }
                                  return null;
                                },
                                keyboadType: TextInputType.number,
                                focusNode: phoneFocus,
                                textInputAction: TextInputAction.next,
                                onfieldSubmit: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(passwordFocus);
                                },
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomTextField(
                                controller: passwordController,
                                labelText: "Password",
                                hideText: hideText,
                                focusNode: passwordFocus,
                                valid: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password should not be empty";
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
                              alignment: Alignment.topRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.forgetPasswordScreen);
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.lato(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: size.width,
            height: size.height * 0.06,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  setState(() {
                    isloading = true;
                  });
                  String status = await Auth.signIn(
                      number: phoneController.text,
                      password: passwordController.text,
                      context: context);

                  setState(() {
                    isloading = false;
                  });
                  if (status == "true") {
                    await ApiService.checkbalance(context);
                    showSnackBar(
                        context: context, message: "Sign in successfully");
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.NavScreen, (route) => false);
                  } else if (status == "Please verify your phone number") {
                    showDialog(
                        context: context,
                        builder: (context) => Customdialog1(
                              otpcontroller: otpController,
                            ));
                  } else {
                    return;
                  }
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
                'LOGIN  SECURELY',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New to Virzanpay? ',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.signUp, (route) => false);
                  },
                  child: Text(
                    "Register now",
                    style: GoogleFonts.lato(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Customdialog1 extends StatefulWidget {
  late TextEditingController otpcontroller;
  Customdialog1({super.key, required this.otpcontroller});

  @override
  State<Customdialog1> createState() => _Customdialog1State();
}

class _Customdialog1State extends State<Customdialog1> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: size.height * 0.2,
        width: size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verification",
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
              "Please verify your phone number to go forward",
              style: GoogleFonts.notoSans(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            SizedBox(
              width: size.width * 0.6,
              height: size.height * 0.06,
              child: ElevatedButton(
                onPressed: () async {
                  print("I am calling without any button presesd+++++++++++");
                  setState(() {
                    loading = true;
                  });

                  bool result = await Auth.resendOtp(context: context);

                  if (result) {
                    setState(() {
                      loading = false;
                    });

                    Navigator.of(context).pop();

                    showDialog(
                      context: context,
                      builder: (context) =>
                          Customdialog2(otpController: widget.otpcontroller),
                    );
                  } else {
                    setState(() {
                      loading = false;
                    });
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
                    Text(
                      "Send code",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    // backgroundColor: Color(0xFFC62828),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                    // padding: EdgeInsets.symmetric(horizontal: 32.0),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Customdialog2 extends StatefulWidget {
  late TextEditingController otpController;
  Customdialog2({super.key, required this.otpController});

  @override
  State<Customdialog2> createState() => _Customdialog2State();
}

class _Customdialog2State extends State<Customdialog2> {
  bool loading = false;
  bool loadingsubmitbutton = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: size.height * 0.33,
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
// style: TextButton.styleFrom(
//   backgroundColor: Colors.red,
// ),
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
                            await sharedPreferences.setBool("islogin", true);
                            await ApiService.checkbalance(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.NavScreen, (route) => false);
                          }
                          setState(() {
                            loadingsubmitbutton = false;
                          });
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
                            Text(
                              "Submit",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
// backgroundColor: Color(0xFFC62828),
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
// padding: EdgeInsets.symmetric(horizontal: 32.0),
                            ),
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
