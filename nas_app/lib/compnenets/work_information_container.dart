import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_app/Model/job_model.dart';
import 'package:nas_app/compnenets/custome_check_box.dart';
import 'package:nas_app/compnenets/positioned.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/compnenets/share_information_dialog.dart';
import 'package:nas_app/controllers/job_information_controller.dart';
import 'package:nas_app/screens/personal_information.dart';
import 'package:nas_app/utils/app_colors.dart';
import 'package:nas_app/utils/styling.dart';

class WorkInformationContainer extends StatefulWidget {
  WorkInformationContainer(
      {Key? key,
      required this.title,
      required this.spaceTitle,
      required this.heightContainer})
      : super(key: key);
  String title;
  double spaceTitle;
  double heightContainer;

  @override
  State<WorkInformationContainer> createState() =>
      _WorkInformationContainerState();
}

class _WorkInformationContainerState extends State<WorkInformationContainer> {
  JobController controller = Get.put(JobController());
  GetStorage signUpBox = GetStorage();

  Color _colorWorkType = Colors.white;
  Color _colorWorkDay = Colors.white;
  Color _colorWorkTime = Colors.white;
  Color _colorWorkTime2 = Colors.white;
  Color _colorHoliday = Colors.white;
  Color _colorTravel = Colors.white;
  Color _colorMoneyReceive = Colors.white;
  Color _buttonColor = Colors.white;

  bool _validation() {
    bool _validWorkType = false;
    bool _validWorkDay = false;
    bool _validWorkTime = false;
    bool _validWorkTime2 = false;
    bool _validHoliday = false;
    bool _validTravel = false;
    bool _validMoneyReceive = false;

    for (var element in controller.jobs) {
      if (element.active!) {
        setState(() {
          _colorWorkType = Colors.white;
          _validWorkType = true;
        });
      }
    }
    for (var element in controller.workDay) {
      if (element.active) {
        setState(() {
          _colorWorkDay = Colors.white;
          _validWorkDay = true;
        });
      }
    }
    for (var element in controller.workTime) {
      if (element.active) {
        setState(() {
          _colorWorkTime = Colors.white;
          _validWorkTime = true;
        });
      }
    }
    for (var element in controller.workTime2) {
      if (element.active) {
        setState(() {
          _colorWorkTime2 = Colors.white;
          _validWorkTime2 = true;
        });
      }
    }
    for (var element in controller.holiday) {
      if (element.active) {
        setState(() {
          _colorHoliday = Colors.white;
          _validHoliday = true;
        });
      }
    }
    for (var element in controller.travel) {
      if (element.active) {
        setState(() {
          _colorTravel = Colors.white;
          _validTravel = true;
        });
      }
    }
    for (var element in controller.moneyReceive) {
      if (element.active) {
        setState(() {
          _colorMoneyReceive = Colors.white;
          _validMoneyReceive = true;
        });
      }
    }

    if (_validWorkType == true) {
      setState(() {
        _colorWorkType = Colors.white;
      });
    } else {
      setState(() {
        _colorWorkType = Colors.red;
        _buttonColor = AppColors.greyColor;
      });
    }

    if (_validWorkDay) {
      setState(() {
        _colorWorkDay = Colors.white;
      });
    } else {
      setState(() {
        _colorWorkDay = Colors.red;
        _buttonColor = AppColors.greyColor;
      });
    }

    if (_validWorkTime) {
      setState(() {
        _colorWorkTime = Colors.white;
      });
    } else {
      setState(() {
        _colorWorkTime = Colors.red;
        _buttonColor = AppColors.greyColor;
      });
    }

    if (_validWorkTime2) {
      setState(() {
        _colorWorkTime2 = Colors.white;
      });
    } else {
      setState(() {
        _colorWorkTime2 = Colors.red;
        _buttonColor = AppColors.greyColor;
      });
    }

    if (_validHoliday) {
      setState(() {
        _colorHoliday = Colors.white;
      });
    } else {
      setState(() {
        _colorHoliday = Colors.red;
        _buttonColor = AppColors.greyColor;
      });
    }

    if (_validTravel) {
      setState(() {
        _colorTravel = Colors.white;
      });
    } else {
      setState(() {
        _colorTravel = Colors.red;
        _buttonColor = AppColors.greyColor;
      });
    }

    if (_validMoneyReceive) {
      setState(() {
        _colorMoneyReceive = Colors.white;
      });
    } else {
      setState(() {
        _colorMoneyReceive = Colors.red;
        _buttonColor = AppColors.greyColor;
      });
    }

    if (_validWorkType &&
        _validWorkDay &&
        _validWorkTime &&
        _validWorkTime2 &&
        _validHoliday &&
        _validTravel &&
        _validMoneyReceive) {
      return true;
    } else {
      return false;
    }
  }

  bool _disabledButton() {
    bool _validWorkType = false;
    bool _validWorkDay = false;
    bool _validWorkTime = false;
    bool _validWorkTime2 = false;
    bool _validHoliday = false;
    bool _validTravel = false;
    bool _validMoneyReceive = false;

    for (var element in controller.jobs) {
      if (element.active!) {
        setState(() {
          _validWorkType = true;
        });
      }
    }
    for (var element in controller.workDay) {
      if (element.active) {
        setState(() {
          _validWorkDay = true;
        });
      }
    }
    for (var element in controller.workTime) {
      if (element.active) {
        setState(() {
          _validWorkTime = true;
        });
      }
    }
    for (var element in controller.workTime2) {
      if (element.active) {
        setState(() {
          _validWorkTime2 = true;
        });
      }
    }
    for (var element in controller.holiday) {
      if (element.active) {
        setState(() {
          _validHoliday = true;
        });
      }
    }
    for (var element in controller.travel) {
      if (element.active) {
        setState(() {
          _validTravel = true;
        });
      }
    }
    for (var element in controller.moneyReceive) {
      if (element.active) {
        setState(() {
          _validMoneyReceive = true;
        });
      }
    }

    if (_validWorkType &&
        _validWorkDay &&
        _validWorkTime &&
        _validWorkTime2 &&
        _validHoliday &&
        _validTravel &&
        _validMoneyReceive) {
      _buttonColor = Colors.white;
      return true;
    } else {
      _buttonColor = AppColors.greyColor;
      return false;
    }
  }

  void attachSelectItem() {
    print("********************************");
    for (var element in controller.jobs) {
      if (element.active == true) {
        signUpBox.write('job_id', element.id);
        print(element.id);
      }
    }

    print("********************************");
    String preferredWorkingDays = "";
    for (var element in controller.workDay) {
      if (element.active == true) {
        String name = element.name + ' ';
        preferredWorkingDays = preferredWorkingDays + name;
      }
    }
    print(preferredWorkingDays);
    signUpBox.write('preferred_working_days', preferredWorkingDays);

    print("********************************");
    String preferredWorkingTimes = "";
    for (var element in controller.workTime) {
      if (element.active == true) {
        String name = element.name + ' ';
        preferredWorkingTimes = preferredWorkingTimes + name;
      }
    }
    print(preferredWorkingTimes);
    signUpBox.write('preferred_working_times', preferredWorkingTimes);

    print("********************************");
    String preferredWorkPeriod = "";
    for (var element in controller.workTime2) {
      if (element.active == true) {
        String name = element.name + ' ';
        preferredWorkPeriod = preferredWorkPeriod + name;
      }
    }
    print(preferredWorkPeriod);
    signUpBox.write('preferred_work_period', preferredWorkPeriod);

    print("********************************");
    String workOnOccasions = "";
    for (var element in controller.holiday) {
      if (element.active == true) {
        if (element.name == "نعم") {
          workOnOccasions = "yes";
          signUpBox.write('work_on_occasions', workOnOccasions);
          print(workOnOccasions);
        } else {
          workOnOccasions = "no";
          signUpBox.write('work_on_occasions', workOnOccasions);
          print(workOnOccasions);
        }
      }
    }
    print("********************************");
    String needForTransportation = "";
    for (var element in controller.travel) {
      if (element.active == true) {
        if (element.name == "نعم") {
          needForTransportation = "yes";
          signUpBox.write('need_for_transportation', needForTransportation);
          print(needForTransportation);
        } else {
          workOnOccasions = "no";
          signUpBox.write('need_for_transportation', needForTransportation);
          print(needForTransportation);
        }
      }
    }

    print("********************************");
    String receiveDues = "";
    for (var element in controller.moneyReceive) {
      if (element.active == true) {
        String name = element.name + ' ';
        receiveDues = receiveDues + name;
      }
    }
    print(receiveDues);
    signUpBox.write('receive_dues', receiveDues);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, right: 5),
          margin: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    color: AppColors.primaryColor,
                    shape: Styling.roundedRectangleBorder,
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    transform: Matrix4.translationValues(
                                        7.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "أختر نوع / انواع العمل المطلوب",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: _colorWorkType,
                                                )),
                                            const SizedBox(width: 5),
                                            GestureDetector(
                                              onTap: () {
                                                _shareInfoDialog();
                                              },
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Icon(Icons.share,
                                                      size: 20,
                                                      color: AppColors
                                                          .secondaryColor)),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text("يمكنك اختيار اكثر من نوع عمل*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                      GetBuilder<JobController>(
                                          builder: (controller) {
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05 *
                                              controller.jobs.length /
                                              2,
                                          child: GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2,
                                                childAspectRatio: (5 / 1),
                                              ),
                                              itemCount: controller.jobs.length,
                                              itemBuilder: (BuildContext ctx,
                                                  int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (controller.jobs[index]
                                                            .hasCheck ==
                                                        1) {
                                                      _checkDialog(controller
                                                          .jobs[index]);
                                                    } else {
                                                      setState(() {
                                                        controller.jobs[index]
                                                                .active =
                                                            !(controller
                                                                .jobs[index]
                                                                .active!);
                                                      });
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      CustomCheckBox(
                                                          fillColor: controller
                                                                      .jobs[
                                                                          index]
                                                                      .active ==
                                                                  false
                                                              ? AppColors
                                                                  .primaryColor
                                                              : AppColors
                                                                  .secondaryColor),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        controller
                                                            .jobs[index].name!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6,
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _infoDialog(controller
                                                              .jobs[index].id);
                                                        },
                                                        child: const Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Icon(
                                                            Icons.info_outline,
                                                            size: 10,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    transform: Matrix4.translationValues(
                                        7.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                            "أختر يوم /أيام التي ترغب بالعمل بها",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: _colorWorkDay,
                                            )),
                                      ),
                                      Text("يمكنك اختيار اكثر من يوم*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                      SizedBox(
                                        height: 100,
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                              childAspectRatio: (3 / 1),
                                            ),
                                            itemCount:
                                                controller.workDay.length,
                                            itemBuilder:
                                                (BuildContext ctx, int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    controller.workDay[index]
                                                            .active =
                                                        !controller
                                                            .workDay[index]
                                                            .active;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    CustomCheckBox(
                                                        fillColor: controller
                                                                    .workDay[
                                                                        index]
                                                                    .active ==
                                                                false
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .secondaryColor),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      controller
                                                          .workDay[index].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    transform: Matrix4.translationValues(
                                        7.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          "أختر وقت /أوقات التي ترغب بالعمل بها",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: _colorWorkTime,
                                          ),
                                        ),
                                      ),
                                      Text("يمكنك اختيار اكثر من وقت*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                      SizedBox(
                                        height: 60,
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                              childAspectRatio: (3 / 1),
                                            ),
                                            itemCount:
                                                controller.workTime.length,
                                            itemBuilder:
                                                (BuildContext ctx, int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    controller.workTime[index]
                                                            .active =
                                                        !controller
                                                            .workTime[index]
                                                            .active;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    CustomCheckBox(
                                                        fillColor: controller
                                                                    .workTime[
                                                                        index]
                                                                    .active ==
                                                                false
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .secondaryColor),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                        controller
                                                            .workTime[index]
                                                            .name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6)
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    transform: Matrix4.translationValues(
                                        7.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          "هل تفضل العمل بالمناسبات والأعياد",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: _colorHoliday,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 70,
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                              childAspectRatio: (3 / 1),
                                            ),
                                            itemCount:
                                                controller.holiday.length,
                                            itemBuilder:
                                                (BuildContext ctx, int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    for (var element
                                                        in controller.holiday) {
                                                      element.active = false;
                                                    }
                                                    controller.holiday[index]
                                                        .active = true;
                                                  });
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 12.4,
                                                      width: 12.4,
                                                      decoration: BoxDecoration(
                                                        color: controller
                                                                    .holiday[
                                                                        index]
                                                                    .active ==
                                                                false
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .secondaryColor,
                                                        border: Border.all(
                                                            width: 1.0,
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      controller
                                                          .holiday[index].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    transform: Matrix4.translationValues(
                                        7.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          "هل تفضل العمل بشكل",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: _colorWorkTime2,
                                          ),
                                        ),
                                      ),
                                      Text("يمكنك اختيار اكثر من طريقة*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                      SizedBox(
                                        height: 60,
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                              childAspectRatio: (3 / 1),
                                            ),
                                            itemCount:
                                                controller.workTime2.length,
                                            itemBuilder:
                                                (BuildContext ctx, int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    controller.workTime2[index]
                                                            .active =
                                                        !controller
                                                            .workTime2[index]
                                                            .active;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    CustomCheckBox(
                                                        fillColor: controller
                                                                    .workTime2[
                                                                        index]
                                                                    .active ==
                                                                false
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .secondaryColor),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      controller
                                                          .workTime2[index]
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    transform: Matrix4.translationValues(
                                        7.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          "كيف تفضل استلام مستحقاتك",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: _colorMoneyReceive,
                                          ),
                                        ),
                                      ),
                                      Text("يمكنك اختيار اكثر من طريقة*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                      SizedBox(
                                        height: 60,
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                              childAspectRatio: (3 / 1),
                                            ),
                                            itemCount:
                                                controller.moneyReceive.length,
                                            itemBuilder:
                                                (BuildContext ctx, int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    controller
                                                            .moneyReceive[index]
                                                            .active =
                                                        !controller
                                                            .moneyReceive[index]
                                                            .active;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    CustomCheckBox(
                                                        fillColor: controller
                                                                    .moneyReceive[
                                                                        index]
                                                                    .active ==
                                                                false
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .secondaryColor),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      controller
                                                          .moneyReceive[index]
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    transform: Matrix4.translationValues(
                                        7.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          "هل تحتاج إلى مواصلات من وإلى العمل",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: _colorTravel,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 70,
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                              childAspectRatio: (3 / 1),
                                            ),
                                            itemCount: controller.travel.length,
                                            itemBuilder:
                                                (BuildContext ctx, int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    for (var element
                                                        in controller.travel) {
                                                      element.active = false;
                                                    }
                                                    controller.travel[index]
                                                        .active = true;
                                                  });
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 12.4,
                                                      width: 12.4,
                                                      decoration: BoxDecoration(
                                                        color: controller
                                                                    .travel[
                                                                        index]
                                                                    .active ==
                                                                false
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .secondaryColor,
                                                        border: Border.all(
                                                            width: 1.0,
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      controller
                                                          .travel[index].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                      ),
                    )),
              ),
              PositionedOne(spaceTitle: widget.spaceTitle),
              PositionedTwo(title: widget.title),
              const PositionedThree()
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
                  if (_validation()) {
                    attachSelectItem();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PersonalInformation()));
                  }
                },
                child: PrimaryButton(
                  title: "التالي",
                  textColor: _disabledButton()
                      ? AppColors.primaryColor
                      : AppColors.secondaryColor,
                  textSize: 14,
                  fillColor: _disabledButton()
                      ? AppColors.secondaryColor
                      : AppColors.greyColor,
                  borderColor: AppColors.secondaryColor,
                  height: 31.15,
                  width: 110,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
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
      ],
    );
  }

  Future<void> _shareInfoDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const ShareInformationDialog();
      },
    );
  }

  Future<void> _infoDialog(int? id) async {
    await controller.fetchJobDesc(id!);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 290.19,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Icon(
                          Icons.circle,
                          color: AppColors.primaryColor,
                          size: 18,
                        ),
                      ),
                      SizedBox(
                        width: 190,
                        child: Text(controller.jobDesc.name!,
                            style: Theme.of(context).textTheme.bodyText2),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _checkDialog(JobModel jobModel) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 200.19,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                Center(
                  child: SizedBox(
                    child: Text("هل تفضل التعامل بالكحول  ؟",
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            jobModel.active = true;
                            Navigator.pop(context);
                          });
                        },
                        child: PrimaryButton(
                          title: "نعم",
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
                          setState(() {
                            jobModel.active = false;
                            Navigator.pop(context);
                          });
                        },
                        child: PrimaryButton(
                          title: "لا",
                          textColor: AppColors.secondaryColor,
                          textSize: 14,
                          fillColor: AppColors.primaryColor,
                          borderColor: AppColors.primaryColor,
                          height: 31.15,
                          width: 88.86,
                        ),
                      ),
                    ],
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
