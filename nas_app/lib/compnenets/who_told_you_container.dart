import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_app/compnenets/positioned.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/compnenets/primary_container.dart';
import 'package:nas_app/controllers/who_told_you_controller.dart';
import 'package:nas_app/screens/work_information.dart';
import 'package:nas_app/utils/app_colors.dart';
import 'package:nas_app/utils/styling.dart';

class WhoToldYouContainer extends StatefulWidget {
  WhoToldYouContainer(
      {Key? key,
      required this.title,
      required this.spaceTitle,
      required this.heightContainer})
      : super(key: key);
  String title;
  double spaceTitle;
  double heightContainer;

  @override
  State<WhoToldYouContainer> createState() => _WhoToldYouContainerState();
}

class _WhoToldYouContainerState extends State<WhoToldYouContainer> {
  GetStorage signUpBox = GetStorage();

  WhoToldYouController controller = Get.put(WhoToldYouController());

  TextEditingController phoneNo = TextEditingController();
  TextEditingController otherSources = TextEditingController();

  Color validationNasProjectManager = AppColors.secondaryColor,
      validationOtherSources = AppColors.secondaryColor,
      validationSocialMedia = AppColors.secondaryColor,
      validationWorkingOffice = AppColors.secondaryColor;

  bool expansion1 = false,
      expansion2 = false,
      expansion3 = false,
      expansion4 = false;

  bool _select1 = false, _select2 = false, _select3 = false, _select4 = false;

  var expansionHasData = false;

  bool _disabledButton() {
    if (_select1 || _select2 || _select3 || _select4) {
      return false;
    } else {
      return true;
    }
  }

  bool _validation() {
    if (_select2) {
      if (phoneNo.text.length == 10 && phoneNo.text.startsWith("07")) {
        validationNasProjectManager = Colors.white;
        return true;
      } else {
        setState(() {
          validationNasProjectManager = Colors.red;
          validationOtherSources = Colors.white;
        });
        return false;
      }
    } else if (_select4) {
      if (otherSources.text.length > 3 && checkLanguageOtherSource()) {
        validationOtherSources = Colors.white;
        return true;
      } else {
        setState(() {
          validationOtherSources = Colors.red;
          validationNasProjectManager = Colors.white;
        });
        return false;
      }
    } else if (_select3) {
      return true;
    } else if (_select1) {
      return true;
    } else {
      return false;
    }
  }

  void _selectSocialMedia() {
    phoneNo.text = "";
    otherSources.text = "";
    for (var element in controller.operatingDesk.option) {
      element.active = false;
    }
    _select1 = true;
    _select2 = false;
    _select3 = false;
    _select4 = false;
  }

  void _selectNasProjectManager() {
    otherSources.text = "";
    for (var element in controller.operatingDesk.option) {
      element.active = false;
    }
    for (var element in controller.socialMedia.option) {
      element.active = false;
    }
    _select1 = false;
    _select2 = true;
    _select3 = false;
    _select4 = false;
  }

  void _selectOperatingOffice() {
    otherSources.text = "";
    phoneNo.text = "";
    for (var element in controller.socialMedia.option) {
      element.active = false;
    }
    _select1 = false;
    _select2 = false;
    _select3 = true;
    _select4 = false;
  }

  void _selectOtherSources() {
    phoneNo.text = "";
    for (var element in controller.operatingDesk.option) {
      element.active = false;
    }
    for (var element in controller.socialMedia.option) {
      element.active = false;
    }
    _select1 = false;
    _select2 = false;
    _select3 = false;
    _select4 = true;
  }

  void attachSelectItem() {
    for (var element in controller.operatingDesk.option) {
      if (element.active == true) {
        signUpBox.write('told_id', 3);
        signUpBox.write('told_value', element.name);
        print(element.name);
      }
    }

    for (var element in controller.socialMedia.option) {
      if (element.active == true) {
        signUpBox.write('told_id', 1);
        signUpBox.write('told_value', element.name);
        print(element.name);
      }
    }

    if (phoneNo.text.isNotEmpty) {
      signUpBox.write('told_id', 2);
      signUpBox.write('told_value', phoneNo.text);
      print(phoneNo.text);
    }

    if (otherSources.text.isNotEmpty) {
      signUpBox.write('told_id', 4);
      signUpBox.write('told_value', otherSources.text);
      print(phoneNo.text);
    }
  }

  bool checkLanguageOtherSource() {
    for (int i = 0; i < otherSources.text.length; i++) {
      if (otherSources.text[i]
          .contains(RegExp(r'^[a-zA-Z0-9_\-?=@^,*/{}|\.;+]+$'))) {
        return false;
      }
    }
    return true;
  }

  void submit() {
    setState(() {
      if ((_select1 || _select2 || _select3 || _select4) == true) {
        validationWorkingOffice = Colors.white;
        validationSocialMedia = Colors.white;
        validationOtherSources = Colors.white;
        validationNasProjectManager = Colors.white;
        if (_validation()) {
          validationWorkingOffice = Colors.white;
          validationSocialMedia = Colors.white;
          validationOtherSources = Colors.white;
          validationNasProjectManager = Colors.white;
          attachSelectItem();
          Get.to(const WorkInformation());
        }
      } else {
        validationWorkingOffice = Colors.red;
        validationSocialMedia = Colors.red;
        validationOtherSources = Colors.red;
        validationNasProjectManager = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhoToldYouController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            verticalDirection: VerticalDirection.down,
            children: [
              PrimaryContainer(
                title: "طلب تسجيل",
                spaceTitle: 110,
                containWidget: Text(
                    controller.welcomeMessage ?? "",
                    style: Theme.of(context).textTheme.headline6),
              ),
              Column(
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
                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 4),
                                        transform:
                                            Matrix4.translationValues(23.0, 0.0, 0.0),
                                        child: ExpansionTile(
                                          onExpansionChanged: (isExpanded) {
                                            setState(() {
                                              expansion1 = isExpanded;
                                              if (isExpanded) {
                                                expansion2 = false;
                                                expansion3 = false;
                                                expansion4 = false;
                                              }
                                            });
                                          },
                                          trailing: const SizedBox.shrink(),
                                          collapsedBackgroundColor:
                                              Colors.transparent,
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 5.0),
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(50)),
                                                ),
                                              ),
                                              const SizedBox(width: 30),
                                              Column(
                                                children: [
                                                  Text("وسائل التواصل الإجتماعي",
                                                      style: TextStyle(
                                                          color:
                                                              validationSocialMedia,
                                                          fontSize: 14)),
                                                ],
                                              )
                                            ],
                                          ),
                                          children: [
                                            expansion1
                                                ? Container(
                                                    transform:
                                                        Matrix4.translationValues(
                                                            -60.0, 0.0, 0.0),
                                                    height: 180,
                                                    margin: const EdgeInsets.only(
                                                        top: 5,
                                                        bottom: 5,
                                                        left: 5,
                                                        right: 5),
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: controller
                                                          .socialMedia.option.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              for (var element
                                                                  in controller
                                                                      .socialMedia
                                                                      .option) {
                                                                element.active =
                                                                    false;
                                                              }
                                                              controller
                                                                  .socialMedia
                                                                  .option[index]
                                                                  .active = true;
                                                              _selectSocialMedia();
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                    top: 5.0,
                                                                    bottom: 5),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize.max,
                                                              children: <Widget>[
                                                                Container(
                                                                  height: 12.4,
                                                                  width: 12.4,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: controller
                                                                            .socialMedia
                                                                            .option[
                                                                                index]
                                                                            .active
                                                                        ? Colors.white
                                                                        : Colors
                                                                            .black,
                                                                    border: Border.all(
                                                                        width: 2.0,
                                                                        color: Colors
                                                                            .white),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                50),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    width: 190,
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child: Text(
                                                                        controller
                                                                            .socialMedia
                                                                            .option[
                                                                                index]
                                                                            .name,
                                                                        style: Theme.of(
                                                                                context)
                                                                            .textTheme
                                                                            .headline6))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 4),
                                        transform:
                                            Matrix4.translationValues(23.0, 0.0, 0.0),
                                        child: ExpansionTile(
                                          onExpansionChanged: (isExpanded) {
                                            setState(() {
                                              expansion2 = isExpanded;
                                              if (isExpanded) {
                                                expansion1 = false;
                                                expansion3 = false;
                                                expansion4 = false;
                                              }
                                            });
                                          },
                                          trailing: const SizedBox.shrink(),
                                          collapsedBackgroundColor:
                                              Colors.transparent,
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 5.0),
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(50)),
                                                ),
                                              ),
                                              const SizedBox(width: 30),
                                              Column(
                                                children: [
                                                  Text("مدير بمشروع ناس",
                                                      style: TextStyle(
                                                          color:
                                                              validationNasProjectManager,
                                                          fontSize: 14)),
                                                ],
                                              )
                                            ],
                                          ),
                                          children: [
                                            expansion2
                                                ? Container(
                                                    padding: const EdgeInsets.only(
                                                        right: 50),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "*أرقام أجنبية تبدأ بـ 07",
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: AppColors
                                                                  .greyColor),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: 8.0),
                                                          child: SizedBox(
                                                            height: 31.15,
                                                            child: TextField(
                                                              onChanged: (text) {
                                                                setState(() {
                                                                  _selectNasProjectManager();
                                                                });
                                                              },
                                                              keyboardType:
                                                                  TextInputType.phone,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              controller: phoneNo,
                                                              style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 14),
                                                              decoration:
                                                                  InputDecoration(
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color:
                                                                          validationNasProjectManager,
                                                                      width: 1.0),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color: Colors
                                                                              .white,
                                                                          width: 1.0),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0),
                                                                ),
                                                                labelStyle:
                                                                    const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize: 14),
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right: 30.0),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0),
                                                                ),
                                                                label: SizedBox(
                                                                  width: 190,
                                                                  child: Row(
                                                                    children: const [
                                                                      Icon(
                                                                        Icons.circle,
                                                                        color: Colors
                                                                            .white,
                                                                        size: 12,
                                                                      ),
                                                                      SizedBox(
                                                                          width: 12),
                                                                      Text(
                                                                          "رقم هاتف المدير اللي عزمك")
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              autofocus: false,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 4),
                                        transform:
                                            Matrix4.translationValues(23.0, 0.0, 0.0),
                                        child: ExpansionTile(
                                          onExpansionChanged: (isExpanded) {
                                            setState(() {
                                              expansion3 = isExpanded;
                                              if (isExpanded) {
                                                expansion1 = false;
                                                expansion2 = false;
                                                expansion4 = false;
                                              }
                                            });
                                          },
                                          trailing: const SizedBox.shrink(),
                                          collapsedBackgroundColor:
                                              Colors.transparent,
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 5.0),
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(50)),
                                                ),
                                              ),
                                              const SizedBox(width: 30),
                                              Column(
                                                children: [
                                                  Text("مكتب تشغيل",
                                                      style: TextStyle(
                                                          color:
                                                              validationWorkingOffice,
                                                          fontSize: 14)),
                                                ],
                                              )
                                            ],
                                          ),
                                          children: [
                                            expansion3
                                                ? Container(
                                                    transform:
                                                        Matrix4.translationValues(
                                                            -60.0, 0.0, 0.0),
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.05 *
                                                        controller.operatingDesk
                                                            .option.length + 15,
                                                    margin: const EdgeInsets.only(
                                                        top: 5,
                                                        bottom: 5,
                                                        left: 5,
                                                        right: 5),
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount: controller
                                                          .operatingDesk
                                                          .option
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              for (var element
                                                                  in controller
                                                                      .operatingDesk
                                                                      .option) {
                                                                element.active =
                                                                    false;
                                                              }
                                                              controller
                                                                  .operatingDesk
                                                                  .option[index]
                                                                  .active = true;
                                                              _selectOperatingOffice();
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                    top: 5.0,
                                                                    bottom: 5),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize.max,
                                                              children: <Widget>[
                                                                Container(
                                                                  height: 12.4,
                                                                  width: 12.4,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: controller
                                                                            .operatingDesk
                                                                            .option[
                                                                                index]
                                                                            .active
                                                                        ? Colors.white
                                                                        : Colors
                                                                            .black,
                                                                    border: Border.all(
                                                                        width: 2.0,
                                                                        color: Colors
                                                                            .white),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                50),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    width: 190,
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child: Text(
                                                                        controller
                                                                            .operatingDesk
                                                                            .option[
                                                                                index]
                                                                            .name,
                                                                        style: Theme.of(
                                                                                context)
                                                                            .textTheme
                                                                            .headline6))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 4),
                                        transform:
                                            Matrix4.translationValues(23.0, 0.0, 0.0),
                                        child: ExpansionTile(
                                          onExpansionChanged: (isExpanded) {
                                            setState(() {
                                              expansion4 = isExpanded;
                                              if (isExpanded) {
                                                expansion1 = false;
                                                expansion2 = false;
                                                expansion3 = false;
                                              }
                                            });
                                          },
                                          trailing: const SizedBox.shrink(),
                                          collapsedBackgroundColor:
                                              Colors.transparent,
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 5.0),
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(50)),
                                                ),
                                              ),
                                              const SizedBox(width: 30),
                                              Column(
                                                children: [
                                                  Text("مصادر آخرى",
                                                      style: TextStyle(
                                                          color:
                                                              validationOtherSources,
                                                          fontSize: 14)),
                                                ],
                                              )
                                            ],
                                          ),
                                          children: [
                                            expansion4
                                                ? Container(
                                                    padding: const EdgeInsets.only(
                                                        right: 50),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Container(
                                                        height: 90,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    20),
                                                            border: Border.all(
                                                                color:
                                                                    validationOtherSources,
                                                                width: 1.0)),
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 10.0),
                                                          child: TextFormField(
                                                            onChanged: (text) {
                                                              setState(() {
                                                                _selectOtherSources();
                                                              });
                                                            },
                                                            maxLength: 30,
                                                            controller: otherSources,
                                                            keyboardType:
                                                                TextInputType
                                                                    .multiline,
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 11),
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  InputBorder.none,
                                                            ),
                                                            autofocus: false,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 30)
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        PositionedOne(spaceTitle: widget.spaceTitle),
                        PositionedTwo(title: widget.title),
                        const PositionedThree(),
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
                            submit();
                          },
                          child: PrimaryButton(
                            title: "التالي",
                            textColor: _disabledButton()
                                ? AppColors.secondaryColor
                                : AppColors.primaryColor,
                            textSize: 14,
                            fillColor: _disabledButton()
                                ? AppColors.greyColor
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
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
