import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_app/Model/appointment_model.dart';
import 'package:nas_app/Model/select_available_date_model.dart';
import 'package:nas_app/compnenets/custome_radio_button.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/controllers/home_controller.dart';
import 'package:nas_app/controllers/interview_date_controller.dart';
import 'package:nas_app/screens/home_page.dart';
import 'package:nas_app/utils/app_colors.dart';

class ChangeDateDialog extends StatefulWidget {
  const ChangeDateDialog({Key? key}) : super(key: key);

  @override
  _ChangeDateDialogState createState() => _ChangeDateDialogState();
}

class _ChangeDateDialogState extends State<ChangeDateDialog> {


  Color titleColor = AppColors.primaryColor;

  bool _selectInterview(List<Appointment> app){
    for( var element in app){
      if (element.isSelected == true) {
        return true;
      }
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<InterviewDateController>(
      init: InterviewDateController(),
      builder: (controller) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: controller.changeAppointments.isNotEmpty ? 350.19 : 250,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    for( var element in controller.changeAppointments){
                      element.isSelected = false;
                    }
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
                  children: [
                    Text("يرجى اختيار الموعد الأنسب لك",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ))
                  ],
                ),
                const SizedBox(height: 15),
                controller.changeAppointments.isNotEmpty
                    ? SizedBox(
                        height: 150,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.changeAppointments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  for (var element in controller.changeAppointments) {
                                    element.isSelected = false;
                                  }
                                  controller.changeAppointments[index].isSelected =
                                      true;
                                });
                              },
                              child: CustomRadioItem(
                                  controller.changeAppointments[index]),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            "لا يوجد مواعيد حاليا",
                            style: TextStyle(
                                fontSize: 15, color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: controller.changeAppointments.isNotEmpty ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<HomeController>(
                          init: HomeController(),
                          builder: (homeController) {
                          return GestureDetector(
                            onTap: ()  {
                              if(_selectInterview(controller.changeAppointments)){
                                setState(() {
                                  titleColor = AppColors.primaryColor;
                                });
                                Navigator.pop(context);
                                homeController.onInit();
                                for( var element in controller.changeAppointments){
                                  element.isSelected = false;
                                }
                              } else {
                                setState(() {
                                  titleColor = Colors.red;
                                });
                              }
                            },
                            child: PrimaryButton(
                              title: "تأكيد وأرسال",
                              textColor: AppColors.secondaryColor,
                              textSize: 14,
                              fillColor: _selectInterview(controller.changeAppointments) ? AppColors.primaryColor : Colors.grey.shade600,
                              borderColor: _selectInterview(controller.changeAppointments) ? AppColors.primaryColor : Colors.grey.shade600,
                              height: 31.15,
                              width: 86.86,
                            ),
                          );
                        }
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  const HomePage()));
                          for( var element in controller.changeAppointments){
                            element.isSelected = false;
                          }
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
                  ) :Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        for( var element in controller.changeAppointments){
                          element.isSelected = false;
                        }
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
