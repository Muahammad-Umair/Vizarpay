import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/appbar.dart';
import 'package:virzanpay/Utilies/Widget/image_picker.dart';
import 'package:virzanpay/Utilies/Widget/textfield.dart';
import 'package:virzanpay/Utilies/constant.dart';
import 'package:virzanpay/generated/assets.dart';

import '../../Controller/kyc_check_controller.dart';

//TO update the account
class AccountUpdateScreen extends StatefulWidget {
  const AccountUpdateScreen({super.key});

  @override
  State<AccountUpdateScreen> createState() => _AccountUpdateScreenState();
}

class _AccountUpdateScreenState extends State<AccountUpdateScreen> {
  //name controller
  late TextEditingController _nameTextC;

  // Authentication controller
  late TextEditingController _oldpasswordTextC;
  late TextEditingController _newpasswordTextC;
  late TextEditingController _confirmpasswordTextC;

  // payment controller
  bool loading1 = false;
  bool loading2 = false;
  String netImage = '';
  @override
  void initState() {
    _nameTextC =
        TextEditingController(text: sharedPreferences.getString('fname') ?? '');
    _oldpasswordTextC = TextEditingController();
    _newpasswordTextC = TextEditingController();
    _confirmpasswordTextC = TextEditingController();
    netImage = sharedPreferences.getString('image') ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _nameTextC.dispose();
    _oldpasswordTextC.dispose();
    _newpasswordTextC.dispose();
    _confirmpasswordTextC.dispose();
    super.dispose();
  }

  String imagePath = '';
  String image64 = '';
  bool hidspassword1 = true;
  bool hidspassword2 = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final kycController = context.read<KycController>();
    return Scaffold(
      // backgroundColor: Materialcolor.backgroundColor,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(toolBarHeight),
        child: CustomAppBar(
          title: "Account Update",
          centerTitle: false,
          backbutton: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                          title: const Text("Select image using"),
                          children: [
                            Column(
                              children: [
                                SimpleDialogOption(
                                  onPressed: () async {
                                    ImagePickerModule imageModule =
                                        ImagePickerModule();
                                    final path = await imageModule
                                        .pickImage(ImageSource.camera);
                                    if (path.isNotEmpty) {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        netImage = '';
                                        imagePath = path;
                                      });
                                    }
                                  },
                                  child: const ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text("Camera"),
                                  ),
                                ),
                                SimpleDialogOption(
                                  onPressed: () async {
                                    ImagePickerModule imageModule =
                                        ImagePickerModule();
                                    final path = await imageModule
                                        .pickImage(ImageSource.gallery);
                                    if (path.isNotEmpty) {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        netImage = '';
                                        imagePath = path;
                                      });
                                    }
                                  },
                                  child: const ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text("Gallery"),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    );
                  },
                  child: CircleAvatar(
                    radius: size.width * 0.11,
                    backgroundImage: netImage.isNotEmpty
                        ? NetworkImage(
                            netImage,
                          )
                        : imagePath.isEmpty
                            ? const AssetImage(Assets.imagesProfileImage)
                            : FileImage(File(imagePath)) as ImageProvider,
                  ),
                ),
              ),
              kycController.kycStatus == 'No'
                  ? Text(
                      "Name",
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: textfieldlabelColor,
                          fontSize: labelfontSize,
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: size.height * 0.003,
              ),
              kycController.kycStatus == 'No'
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomTextField(
                        controller: _nameTextC,
                        labelTextfontSize: 14,
                        labelText: "Enter your name",
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: size.height * 0.015,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                    width: size.width * 0.3,
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () async {
                        setState(() {
                          loading1 = true;
                        });

                        if (imagePath.isNotEmpty) {
                          List<int> imagebytes =
                              await File(imagePath).readAsBytes();
                          image64 = base64Encode(imagebytes);
                        }

                        bool status = await ApiService.updateNameImage(
                            context: context,
                            imagebase64: image64,
                            name: _nameTextC.text.trim());
                        if (status) {
                          imagePath = '';
                          _nameTextC.clear();
                        }
                        setState(() {
                          loading1 = false;
                        });
                      },
                      child: loading1
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text("Update"),
                    )),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                "Old Password",
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: textfieldlabelColor,
                    fontSize: labelfontSize,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.003,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: CustomTextField(
                  controller: _oldpasswordTextC,
                  labelText: "Enter your old password",
                  hideText: hidspassword1,
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        hidspassword1 = !hidspassword1;
                      });
                    },
                    icon: Icon(
                      hidspassword1
                          ? Icons.visibility_off_rounded
                          : Icons.visibility,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                "New Password",
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: textfieldlabelColor,
                    fontSize: labelfontSize,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.003,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: CustomTextField(
                  controller: _newpasswordTextC,
                  labelText: "Enter your new password",
                  hideText: hidspassword2,
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        hidspassword2 = !hidspassword2;
                      });
                    },
                    icon: Icon(
                      hidspassword2
                          ? Icons.visibility_off_rounded
                          : Icons.visibility,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.01,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                    width: size.width * 0.3,
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      onPressed: () async {
                        if (_oldpasswordTextC.text.isEmpty &&
                            _newpasswordTextC.text.isEmpty) {
                          return;
                        }
                        setState(() {
                          loading2 = true;
                        });

                        bool status = await ApiService.updatePassword(
                          context: context,
                          newpassword: _newpasswordTextC.text.trim(),
                          oldpassword: _oldpasswordTextC.text.trim(),
                        );
                        if (status) {
                          _oldpasswordTextC.clear();
                          _newpasswordTextC.clear();
                          setState(() {
                            loading2 = false;
                          });
                        }
                        setState(() {
                          loading2 = false;
                        });
                      },
                      child: loading2
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text("Update"),
                    )),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              // Container(
              //     height: size.height * 0.1,
              //     decoration: BoxDecoration(
              //         color: Materialcolor.appbarColor,
              //         boxShadow: const [
              //           BoxShadow(
              //               color: Colors.black26,
              //               blurRadius: 4,
              //               offset: Offset(1, 1)),
              //           BoxShadow(
              //             color: Colors.black26,
              //             blurRadius: 4,
              //             offset: Offset(-1, -1),
              //           ),
              //         ],
              //         borderRadius: BorderRadius.circular(10)),
              //     child: Center(
              //       child: ListTile(
              //         leading: SizedBox(),
              //         title: Text(
              //           "Google pay",
              //         ),
              //         trailing: IconButton(
              //           onPressed: () {},
              //           icon: Icon(
              //             Icons.arrow_drop_down,
              //           ),
              //         ),
              //       ),
              //     )),
              // SizedBox(
              //   height: size.height * 0.02,
              // ),
              // Container(
              //     height: size.height * 0.1,
              //     decoration: BoxDecoration(
              //         color: Materialcolor.appbarColor,
              //         boxShadow: [
              //           BoxShadow(
              //               color: Colors.black26,
              //               blurRadius: 4,
              //               offset: Offset(1, 1)),
              //           BoxShadow(
              //               color: Colors.black26,
              //               blurRadius: 4,
              //               offset: Offset(-1, -1)),
              //         ],
              //         borderRadius: BorderRadius.circular(10)),
              //     child: Center(
              //         child: Row(
              //       children: [
              //         Image.asset(Assets.imagesPaytm),
              //       ],
              //     ))),
              // SizedBox(
              //   height: size.height * 0.02,
              // ),
              // Container(
              //     height: size.height * 0.1,
              //     decoration: BoxDecoration(
              //       color: Materialcolor.appbarColor,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black26,
              //           blurRadius: 4,
              //           offset: Offset(1, 1),
              //         ),
              //         BoxShadow(
              //           color: Colors.black26,
              //           blurRadius: 4,
              //           offset: Offset(-1, -1),
              //         ),
              //       ],
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Center(
              //         child: Row(
              //       children: [
              //         Image.asset(Assets.imagesPhonepe),
              //       ],
              //     ))),
            ],
          ),
        ),
      ),
    );
  }
}
