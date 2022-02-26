import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:nas_app/compnenets/appointment_container.dart';
import 'package:nas_app/compnenets/change_date_dialog.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/compnenets/primary_container.dart';
import 'package:nas_app/compnenets/small_logo.dart';
import 'package:nas_app/controllers/home_controller.dart';
import 'package:nas_app/screens/splash_screen.dart';
import 'package:nas_app/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.fromLTRB(15, 40, 15, 15),
            child: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmallLogo(),
                          Container(
                            height: 62.92,
                            width: 63.78,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: ExactAssetImage(
                                        'assets/images/main_logo.png'))),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SplashPage()));
                            },
                            child: Container(
                              height: 37,
                              width: 33,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/images/logout.png'))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          verticalDirection: VerticalDirection.down,
                          children: [
                            PrimaryContainer(
                              title: "تنبيه",
                              spaceTitle: 70,
                              containWidget: SizedBox(
                                height: 60,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.messages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text(
                                      controller.messages[index].content ?? '-',
                                      style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 13),
                                    );
                                  },
                                ),
                              ),
                            ),
                            PrimaryContainer(
                              title: "موعد وتفاصيل المقابلة",
                              spaceTitle: 180,
                              containWidget: AppointmentContainer(
                                appointment: controller.appointment,
                                padding: 0,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _changeDateDialog();
                                    },
                                    child: PrimaryButton(
                                      title: "تغيير الموعد",
                                      textColor: AppColors.primaryColor,
                                      textSize: 17,
                                      fillColor: Colors.white,
                                      borderColor: Colors.white,
                                      height: 31.15,
                                      width: 115.31,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _removeDateDialog();
                                    },
                                    child: PrimaryButton(
                                      title: "إلغاء الموعد",
                                      textColor: AppColors.primaryColor,
                                      textSize: 17,
                                      fillColor: Colors.white,
                                      borderColor: Colors.white,
                                      height: 31.15,
                                      width: 115.31,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            PrimaryContainer(
                              title: "المواعيد السابقة",
                              spaceTitle: 150,
                              containWidget: controller
                                      .previousAppointments.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller
                                          .previousAppointments.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return AppointmentContainer(
                                          appointment: controller
                                              .previousAppointments[index],
                                          padding: 5,
                                        );
                                      },
                                    )
                                  : _emptyContainer(
                                      "لا يوجد لديك مواعيد سابقة"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }

  Future<void> _changeDateDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ChangeDateDialog();
      },
    );
  }

  Future<void> _removeDateDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.zero,
              content: Container(
                height: 200.19,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.clear,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 190,
                          child: controller.appointment.date != null
                              ? Text(
                                  "هل أنت متأكد من رغبتك بإلغاء طلب التسجيل بناس؟",
                                  style: Theme.of(context).textTheme.bodyText2)
                              : Center(
                                  child: Text("الرجاء حجز موعد اولا!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: controller.appointment.date != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.cancelledAppointment(
                                        controller.appointment.id!);
                                    Navigator.pop(context);
                                    controller.onInit();
                                  },
                                  child: PrimaryButton(
                                    title: "تأكيد وأرسال",
                                    textColor: AppColors.secondaryColor,
                                    textSize: 14,
                                    fillColor: AppColors.primaryColor,
                                    borderColor: AppColors.primaryColor,
                                    height: 31.15,
                                    width: 86.86,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    controller.onInit();
                                  },
                                  child: PrimaryButton(
                                    title: "إلغاء",
                                    textColor: AppColors.secondaryColor,
                                    textSize: 14,
                                    fillColor: AppColors.primaryColor,
                                    borderColor: AppColors.primaryColor,
                                    height: 31.15,
                                    width: 88.86,
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                controller.onInit();
                              },
                              child: PrimaryButton(
                                title: "إلغاء",
                                textColor: AppColors.secondaryColor,
                                textSize: 14,
                                fillColor: AppColors.primaryColor,
                                borderColor: AppColors.primaryColor,
                                height: 31.15,
                                width: 88.86,
                              ),
                            )),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _emptyContainer(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Center(
          child: Text(title,
              style: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
