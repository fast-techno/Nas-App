import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_app/compnenets/interview_date_container.dart';
import 'package:nas_app/compnenets/medium_logo.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/compnenets/primary_container.dart';
import 'package:nas_app/controllers/interview_date_controller.dart';
import 'package:nas_app/screens/sign_up_password.dart';
import 'package:nas_app/utils/app_colors.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';

class InterviewDate extends StatefulWidget {
  const InterviewDate({Key? key}) : super(key: key);

  @override
  State<InterviewDate> createState() => _InterviewDateState();
}

class _InterviewDateState extends State<InterviewDate> {
  GetStorage signUpBox = GetStorage();
  InterviewDateController controller = Get.put(InterviewDateController());

  bool agree = false;
  bool? dateSelection;
  Color agreeColor = AppColors.secondaryColor;
  Color dateColor = AppColors.secondaryColor;

  bool _validation() {
    return (agree == true && dateSelection == true);
  }

  void _changeColor() {
    setState(() {
      if (agree == true) {
        agreeColor = AppColors.secondaryColor;
      } else {
        agreeColor = Colors.red;
      }
      if (dateSelection == true) {
        dateColor = AppColors.secondaryColor;
      } else {
        dateColor = Colors.red;
      }
    });
  }

  void attachSelectItem() {
    for (var element in controller.appointments) {
      if (element.isSelected == true) {
        signUpBox.write('interview_id', element.id);
        print(element.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 40, 15, 15),
          child: Column(
            children: [
              const MediumLogo(),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: GetBuilder<InterviewDateController>(
                      builder: (controller) {
                      return Column(
                        verticalDirection: VerticalDirection.down,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryContainer(
                            title: "موعد المقابلة",
                            spaceTitle: 120,
                            containWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Text(
                                                    "قم باختيار الموعد الأنسب لك",
                                                    style: TextStyle(
                                                        color: dateColor,
                                                        fontSize: 17,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ),
                                              controller.appointments.isNotEmpty
                                                  ? ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                const NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .appointments.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        for (var element
                                                        in controller
                                                            .appointments) {
                                                          element.isSelected =
                                                          false;
                                                        }
                                                        controller
                                                            .appointments[
                                                        index]
                                                            .isSelected = true;
                                                        dateSelection =
                                                        true;
                                                      });
                                                    },
                                                    child:
                                                    InterViewDateContainer(
                                                      appointment: controller
                                                          .appointments[
                                                      index],
                                                      padding: 5,
                                                    ),
                                                  );
                                                },
                                              )
                                                  : Center(
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 20.0),
                                                  child: Text(
                                                      "لا يوجد مواعيد حاليا لحجزها",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .greyColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          PrimaryContainer(
                            title: "توقيع",
                            spaceTitle: 70,
                            containWidget: Column(
                              children: [
                                Html(
                                  data: controller.termsAgree,
                                  style: {
                                    '*': Style(
                                        color: AppColors.greyColor,
                                        fontSize: const FontSize(14)),
                                    'a': Style(
                                        color: Colors.blue,
                                        fontSize: const FontSize(14))
                                  },
                                  onLinkTap: (url, context, map, element) async {
                                    await launch(url.toString());
                                  },
                                ),
                                const SizedBox(height: 40),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      agree = !agree;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        height: 12.4,
                                        width: 12.4,
                                        decoration: BoxDecoration(
                                          color: agree == true
                                              ? AppColors.secondaryColor
                                              : AppColors.primaryColor,
                                          border: Border.all(
                                              width: 1.0,
                                              color: AppColors.secondaryColor),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                      Container(
                                          width: 80,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text("أوافق",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: agreeColor,
                                              )))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _changeColor();
                                    if (_validation()) {
                                      attachSelectItem();
                                      Get.to(const SignUpPassword());
                                    }
                                  },
                                  child: PrimaryButton(
                                    title: "التالي",
                                    textColor: agree == false
                                        ? AppColors.secondaryColor
                                        : AppColors.primaryColor,
                                    textSize: 14,
                                    fillColor: agree == false
                                        ? AppColors.primaryColor
                                        : AppColors.secondaryColor,
                                    borderColor: AppColors.secondaryColor,
                                    height: 31.15,
                                    width: 110,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: PrimaryButton(
                                    title: "عودة",
                                    textColor: AppColors.primaryColor,
                                    textSize: 14,
                                    fillColor: AppColors.secondaryColor,
                                    borderColor: AppColors.secondaryColor,
                                    height: 31.15,
                                    width: 110,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      );
                    }
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
