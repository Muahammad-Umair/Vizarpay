import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:virzanpay/Controller/refer_tree_controller.dart';
import 'package:virzanpay/Model/service.dart';
import 'package:virzanpay/Utilies/Widget/button.dart';
import 'package:virzanpay/generated/assets.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final referTreeController = context.read<ReferTreeController>();
    return RefreshIndicator(
      onRefresh: () async {
        await referTreeController.fetchReferalDiscussion();
        await referTreeController.fetchReferalTree();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Consumer<ReferTreeController>(builder: (context, controller, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("Left User"),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.lightBlue, width: 2)),
                        child: Text(
                          controller.leftRefer.toString(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Right User"),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.lightBlue, width: 2),
                        ),
                        child: Text(controller.rightRefer.toString()),
                      )
                    ],
                  ),
                ],
              );
            }),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              margin: EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              width: double.infinity,
              child: Center(
                child: Text(
                  "UNASSIGN USER",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            FutureBuilder<void>(
              future: fetchData(context),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildLoadingWidget();
                } else if (snapshot.hasError) {
                  return buildErrorWidget(snapshot.error, context);
                } else {
                  return buildDataWidget(context);
                }
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              margin: EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              width: double.infinity,
              child: Center(
                child: Text(
                  "DIRECT USER",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            FutureBuilder<void>(
              future: fetch2Data(context),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildLoadingWidget();
                } else if (snapshot.hasError) {
                  return buildErrorWidget(snapshot.error, context);
                } else {
                  return build2DataWidget(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData(BuildContext context) async {
    final controller = await Provider.of<ReferTreeController>(
      context,
      listen: false,
    );
    await controller.fetchReferalDiscussion();
  }

  Future<void> fetch2Data(BuildContext context) async {
    final controller = await Provider.of<ReferTreeController>(
      context,
      listen: false,
    );
    await controller.fetchReferalTree();
  }

  Widget buildLoadingWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          SizedBox(height: 40),
          Center(
              child: CircularProgressIndicator(
            color: Colors.blueAccent,
          )),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildErrorWidget(dynamic error, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesNoData),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            "Error: $error",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildDataWidget(BuildContext context) {
    List<ReferTree> list = Provider.of<ReferTreeController>(
      context,
    ).unrefertreeList;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 0),
          child: Column(
            children: list.isEmpty
                ? [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.imagesNoData),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      "Refer some user to display",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ]
                : list.map(
                    (referlist) {
                      return FlipInX(
                        duration: const Duration(seconds: 2),
                        child: Container(
                          // height: 60,
                          width: double.infinity,
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 70,
                                height: 35,
                                child: CustomButton(
                                  ontap: () async {
                                    bool status =
                                        await ApiService.checkBinaryStatus(
                                            id: referlist.id,
                                            position: "left",
                                            context: context);
                                    if (status) {
                                      await context
                                          .read<ReferTreeController>()
                                          .fetchReferalDiscussion();
                                    }
                                  },
                                  color: Colors.blueAccent,
                                  widget: Text("Left"),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    referlist.name,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    referlist.phone,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 70,
                                height: 35,
                                child: CustomButton(
                                  ontap: () async {
                                    bool status =
                                        await ApiService.checkBinaryStatus(
                                            id: referlist.id,
                                            position: "right",
                                            context: context);
                                    if (status) {
                                      await context
                                          .read<ReferTreeController>()
                                          .fetchReferalDiscussion();
                                    }
                                  },
                                  color: Colors.blueAccent,
                                  widget: Text("Right"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
          ),
        ),
      ),
    );
  }

  Widget build2DataWidget(BuildContext context) {
    List<ReferTree> list = Provider.of<ReferTreeController>(
      context,
    ).refertreeList;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 0),
          child: Column(
            children: list.isEmpty
                ? [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.imagesNoData),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      "Refer some user to display",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ]
                : list.map(
                    (referlist) {
                      return FlipInX(
                        duration: const Duration(seconds: 2),
                        child: Container(
                          // height: 60,
                          width: double.infinity,
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                referlist.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                referlist.phone,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
          ),
        ),
      ),
    );
  }
}
