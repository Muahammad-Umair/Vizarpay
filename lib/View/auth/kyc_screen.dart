import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/snackbar.dart';
import 'package:virzanpay/Utilies/routes.dart';

class KYCScreen extends StatefulWidget {
  @override
  _KYCScreenState createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  String frontImageAdhr = '';
  String backImageAdhr = '';
  String panImage = '';

  Future<String> pickedImage() async {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Choose image source'),
        actions: [
          ElevatedButton(
            child: Text('Camera'),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          ElevatedButton(
            child: Text('Gallery'),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    ).then((ImageSource? source) async {
      if (source == null) return "";

      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null)
        return "";
      else
        return pickedFile.path;
    });
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    print("it is called again ++++++++++++++++++++++");
    final isback = ModalRoute.of(context)?.settings.arguments ?? false;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150,
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
                    'Register for KYC validation',
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
              height: size.height * 0.04,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Attach Front Side of aadhaar Card',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () async {
                          String path = await pickedImage();
                          if (path.isNotEmpty) {
                            setState(() {
                              frontImageAdhr = path;
                            });
                          }
                        },
                        child: Container(
                          height: 130,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFF8BBD0),
                              ),
                            ],
                            color: Colors.blueAccent,
                          ),
                          child: frontImageAdhr.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(frontImageAdhr),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Text(
                        'Attach Back Side of aadhaar Card',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () async {
                          String path = await pickedImage();
                          if (path.isNotEmpty) {
                            setState(() {
                              backImageAdhr = path;
                            });
                          }
                        },
                        child: Container(
                          height: 130,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFF8BBD0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: backImageAdhr.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(backImageAdhr),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Text(
                        'Attach pan card',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () async {
                          String path = await pickedImage();
                          if (path.isNotEmpty) {
                            setState(() {
                              panImage = path;
                            });
                          }
                        },
                        child: Container(
                          height: 130,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFF8BBD0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: panImage.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(panImage),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Align(
                        child: SizedBox(
                          width: size.width * 0.6,
                          height: size.height * 0.06,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              if (frontImageAdhr.isEmpty) {
                                showSnackBar(
                                    context: context,
                                    message:
                                        "Aadhaar card front image must not empty",
                                    error: true);
                                return;
                              } else if (backImageAdhr.isEmpty) {
                                showSnackBar(
                                    context: context,
                                    message:
                                        "Aadhaar card back image must not empty",
                                    error: true);
                                return;
                              } else if (panImage.isEmpty) {
                                showSnackBar(
                                    context: context,
                                    message: "Pan card image must not empty",
                                    error: true);
                                return;
                              } else {
                                setState(() {
                                  loading = true;
                                });

                                List<int> imageBytes =
                                    await File(frontImageAdhr).readAsBytes();
                                String aadharf64 = base64Encode(imageBytes);
                                List<int> imageBytes2 =
                                    await File(backImageAdhr).readAsBytes();
                                String aadharb64 = base64Encode(imageBytes2);

                                List<int> imageBytes3 =
                                    await File(panImage).readAsBytes();
                                String pan64 = base64Encode(imageBytes3);

                                bool status = await ApiService.kyc(
                                    context: context,
                                    aadharFront: aadharf64,
                                    aadharBack: aadharb64,
                                    panCard: pan64);
                                if (status) {
                                  setState(() {
                                    loading = false;
                                  });
                                  isback == true
                                      ? Navigator.of(context).pop()
                                      : Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.NavScreen,
                                          (route) => false);
                                }
                                if (mounted) {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              }
                            },
                            icon: Row(
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
                                const Icon(Icons.lock_outline),
                              ],
                            ),
                            label: Text(
                              'Submit Securely',
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
