import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_app/Model/radio_button_model.dart';
import 'package:nas_app/compnenets/positioned.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/compnenets/share_information_dialog.dart';
import 'package:nas_app/screens/relatives_information.dart';
import 'package:nas_app/utils/app_colors.dart';
import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class PersonalInformationContainer extends StatefulWidget {
  PersonalInformationContainer(
      {Key? key,
      required this.title,
      required this.spaceTitle,
      required this.heightContainer})
      : super(key: key);
  String title;
  double spaceTitle;
  double heightContainer;

  @override
  State<PersonalInformationContainer> createState() =>
      _PersonalInformationContainerState();
}

class _PersonalInformationContainerState
    extends State<PersonalInformationContainer> {
  GetStorage signUpBox = GetStorage();
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;
  String? _verificationCode;
  String checkPhoneNo = "";
  Timer? _timer;
  int _start = 30;
  bool resendCode = false;
  bool enterCode = false;

  List<RadioButtonModel> sexType = [];
  List<RadioButtonModel> socialStatus = [];

  String? dropdownValueYear;
  String? dropdownValueMonth;
  String? dropdownValueDay;
  String? dropdownValueNationality;
  String? dropdownValueHome;
  bool? sexTypeSelection;
  bool? socialSelection;

  TextEditingController firstName = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController grandFatherName = TextEditingController();
  TextEditingController finalName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController verifyCode = TextEditingController();

  Color firstNameColor = AppColors.greyColor;
  Color fatherNameColor = AppColors.greyColor;
  Color grandFatherNameColor = AppColors.greyColor;
  Color finalNameColor = AppColors.greyColor;
  Color phoneNoColor = AppColors.greyColor;
  Color idNumberColor = AppColors.greyColor;
  Color areaColor = AppColors.greyColor;
  Color homeListColor = AppColors.greyColor;
  Color nationalityColor = AppColors.greyColor;
  Color yearsColor = AppColors.greyColor;
  Color daysColor = AppColors.greyColor;
  Color monthsColor = AppColors.greyColor;
  Color sexColor = AppColors.greyColor;
  Color socialColor = AppColors.greyColor;
  Color nameLanguageColor = AppColors.secondaryColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sexType.add(RadioButtonModel(name: 'ذكر', active: false));
    sexType.add(RadioButtonModel(name: 'أنثى', active: false));
    socialStatus.add(RadioButtonModel(name: 'أعزب', active: false));
    socialStatus.add(RadioButtonModel(name: 'متزوج', active: false));
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text("تم تأكيد رمز التحقق صحيح")));
        setState(() {
          enterCode = true;
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red, content: Text("رمز التحقق غير صحيح")));
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            resendCode = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  bool checkLanguageFirstName() {
    for (int i = 0; i < firstName.text.length; i++) {
      if (firstName.text[i]
          .contains(RegExp(r'^[a-zA-Z0-9_\-?=@^,*/{}|\.;+]+$'))) {
        return false;
      }
    }
    return true;
  }

  bool checkLanguageSecondName() {
    for (int i = 0; i < fatherName.text.length; i++) {
      if (fatherName.text[i]
          .contains(RegExp(r'^[a-zA-Z0-9_\-?=@^,*/{}|\.;+]+$'))) {
        return false;
      }
    }
    return true;
  }

  bool checkLanguageThirdName() {
    for (int i = 0; i < grandFatherName.text.length; i++) {
      if (grandFatherName.text[i]
          .contains(RegExp(r'^[a-zA-Z0-9_\-?=@^,*/{}|\.;+]+$'))) {
        return false;
      }
    }
    return true;
  }

  bool checkLanguageFinalName() {
    for (int i = 0; i < finalName.text.length; i++) {
      if (finalName.text[i]
          .contains(RegExp(r'^[a-zA-Z0-9_\-?=@^,*/{}|\.;+]+$'))) {
        return false;
      }
    }
    return true;
  }

  bool checkLanguageArea() {
    for (int i = 0; i < area.text.length; i++) {
      if (area.text[i].contains(RegExp(r'^[a-zA-Z0-9_\-?=@^,*/{}|\.;+]+$'))) {
        setState(() {
          areaColor = Colors.red;
        });
        return false;
      }
    }
    setState(() {
      areaColor = AppColors.greyColor;
    });
    return true;
  }

  void attachSelectItem() {
    print("********************************");
    if (firstName.text != null) {
      signUpBox.write('first_name', firstName.text);
      print(firstName.text);
    }

    print("********************************");
    if (fatherName.text != null) {
      signUpBox.write('father_name', fatherName.text);
      print(fatherName.text);
    }

    print("********************************");
    if (grandFatherName.text != null) {
      signUpBox.write('grandfather_name', grandFatherName.text);
      print(grandFatherName.text);
    }

    print("********************************");
    if (finalName.text != null) {
      signUpBox.write('last_name', finalName.text);
      print(finalName.text);
    }

    print("********************************");
    if (dropdownValueDay != null) {
      signUpBox.write('day_of_birth', dropdownValueDay);
      print(dropdownValueDay);
    }
    print("********************************");
    if (dropdownValueYear != null) {
      signUpBox.write('year_of_birth', dropdownValueYear);
      print(dropdownValueYear);
    }
    print("********************************");
    if (dropdownValueMonth != null) {
      signUpBox.write('month_of_birth', dropdownValueMonth);
      print(dropdownValueMonth);
    }

    print("********************************");
    if (phoneNo.text != null) {
      signUpBox.write('phone', phoneNo.text);
      print(phoneNo.text);
    }

    print("********************************");
    String gender = "";
    for (var element in sexType) {
      if (element.active == true) {
        if (element.name == "ذكر") {
          gender = "male";
          signUpBox.write('gender', gender);
          print(gender);
        } else {
          gender = "female";
          signUpBox.write('gender', gender);
          print(gender);
        }
      }
    }

    print("********************************");
    String maritalStatus = "";
    for (var element in socialStatus) {
      if (element.active == true) {
        if (element.name == "متزوج") {
          maritalStatus = "married";
          signUpBox.write('marital_status', maritalStatus);
          print(maritalStatus);
        } else {
          maritalStatus = "unmarried";
          signUpBox.write('marital_status', maritalStatus);
          print(maritalStatus);
        }
      }
    }
    print("********************************");
    if (dropdownValueNationality != null) {
      signUpBox.write('nationality', dropdownValueNationality);
      print(dropdownValueNationality);
    }

    if (dropdownValueNationality == "غير أردني") {
      signUpBox.write('nationality_other', dropdownValueNationality);
      print(dropdownValueNationality);
    }

    print("********************************");
    if (idNumber.text != null) {
      signUpBox.write('national_number', idNumber.text);
      print(idNumber.text);
    }
    print("********************************");
    if (area.text != null) {
      signUpBox.write('area', area.text);
      print(area.text);
    }
    print("********************************");
    if (dropdownValueHome != null) {
      signUpBox.write('governorate', dropdownValueHome);
      print(dropdownValueHome);
    }
  }

  bool _disableButton() {
    if (verifyCode.text.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool _validation() {
    return (firstName.text.isNotEmpty &&
        fatherName.text.isNotEmpty &&
        grandFatherName.text.isNotEmpty &&
        finalName.text.isNotEmpty &&
        phoneNo.text.length == 10 &&
        phoneNo.text.startsWith("07") &&
        idNumber.text.length == 10 &&
        area.text.isNotEmpty &&
        dropdownValueHome != null &&
        dropdownValueNationality != null &&
        dropdownValueYear != null &&
        dropdownValueMonth != null &&
        dropdownValueDay != null &&
        socialSelection == true &&
        sexTypeSelection == true);
  }

  bool disableCodeVerify() {
    if (phoneNo.text.length == 10 && phoneNo.text.startsWith("07")) {
      return false;
    } else {
      return true;
    }
  }

  void _changeColor() {
    firstName.text.isEmpty
        ? setState(() {
            firstNameColor = Colors.red;
          })
        : setState(() {
            firstNameColor = AppColors.greyColor;
          });

    fatherName.text.isEmpty
        ? setState(() {
            fatherNameColor = Colors.red;
          })
        : setState(() {
            fatherNameColor = AppColors.greyColor;
          });

    grandFatherName.text.isEmpty
        ? setState(() {
            grandFatherNameColor = Colors.red;
          })
        : setState(() {
            grandFatherNameColor = AppColors.greyColor;
          });

    finalName.text.isEmpty
        ? setState(() {
            finalNameColor = Colors.red;
          })
        : setState(() {
            finalNameColor = AppColors.greyColor;
          });

    phoneNo.text.length == 10 && phoneNo.text.startsWith("07")
        ? setState(() {
            phoneNoColor = AppColors.greyColor;
          })
        : setState(() {
            phoneNoColor = Colors.red;
          });

    idNumber.text.length == 10
        ? setState(() {
            idNumberColor = AppColors.greyColor;
          })
        : setState(() {
            idNumberColor = Colors.red;
          });

    area.text.isNotEmpty
        ? setState(() {
            areaColor = AppColors.greyColor;
          })
        : setState(() {
            areaColor = Colors.red;
          });

    dropdownValueHome != null
        ? setState(() {
            homeListColor = AppColors.greyColor;
          })
        : setState(() {
            homeListColor = Colors.red;
          });

    dropdownValueNationality != null
        ? setState(() {
            nationalityColor = AppColors.greyColor;
          })
        : setState(() {
            nationalityColor = Colors.red;
          });

    dropdownValueYear != null
        ? setState(() {
            yearsColor = AppColors.greyColor;
          })
        : setState(() {
            yearsColor = Colors.red;
          });

    dropdownValueMonth != null
        ? setState(() {
            monthsColor = AppColors.greyColor;
          })
        : setState(() {
            monthsColor = Colors.red;
          });

    dropdownValueDay != null
        ? setState(() {
            daysColor = AppColors.greyColor;
          })
        : setState(() {
            daysColor = Colors.red;
          });
    int social = 0;
    for (var element in socialStatus) {
      element.active ? social++ : social;
    }
    social > 0
        ? setState(() {
            socialSelection = true;
            socialColor = AppColors.greyColor;
          })
        : setState(() {
            socialSelection = false;
            socialColor = Colors.red;
          });

    int sex = 0;
    for (var element in sexType) {
      element.active ? sex++ : sex;
    }
    sex > 0
        ? setState(() {
            sexTypeSelection = true;
            sexColor = AppColors.greyColor;
          })
        : setState(() {
            sexTypeSelection = false;
            sexColor = Colors.red;
          });
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: AppColors.secondaryColor,
                        width: 1.0,
                      ),
                    ),
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
                                        child: Text("باللغة العربية فقط*",
                                            style: TextStyle(
                                                color: nameLanguageColor,
                                                fontSize: 14)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, bottom: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 31.15,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller: firstName,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  firstNameColor,
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  firstNameColor,
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        labelStyle: TextStyle(
                                                            color: AppColors
                                                                .greyColor,
                                                            fontSize: 14),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(right: 6),
                                                        suffixIcon:
                                                            GestureDetector(
                                                                onTap: () {
                                                                  _shareInfoDialog();
                                                                },
                                                                child: const Icon(
                                                                    Icons.share,
                                                                    size: 12,
                                                                    color: Colors
                                                                        .white)),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        labelText:
                                                            "الأسم الاول",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 31.15,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller: fatherName,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  fatherNameColor,
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  fatherNameColor,
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        labelStyle: TextStyle(
                                                            color: AppColors
                                                                .greyColor,
                                                            fontSize: 14),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(right: 6),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        labelText: "اسم الأب",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 31.15,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          grandFatherName,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  grandFatherNameColor,
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  grandFatherNameColor,
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        labelStyle: TextStyle(
                                                            color: AppColors
                                                                .greyColor,
                                                            fontSize: 14),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(right: 6),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        labelText: "اسم الجد",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 31.15,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      controller: finalName,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  finalNameColor,
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  finalNameColor,
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        suffixIcon:
                                                            GestureDetector(
                                                                onTap: () {
                                                                  _shareInfoDialog();
                                                                },
                                                                child: const Icon(
                                                                    Icons.share,
                                                                    size: 12,
                                                                    color: Colors
                                                                        .white)),
                                                        labelStyle: TextStyle(
                                                            color: AppColors
                                                                .greyColor,
                                                            fontSize: 14),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(right: 6),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        labelText:
                                                            "اسم العائلة",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, bottom: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: daysColor,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                height: 31,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Center(
                                                    child:
                                                        DropdownSearch<String>(
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          dropdownValueDay =
                                                              newValue ?? "";

                                                          print(
                                                              dropdownValueDay);
                                                        });
                                                      },
                                                      dropDownButton:
                                                          Visibility(
                                                        visible: false,
                                                        child: Icon(
                                                          Icons.savings_sharp,
                                                          size: 2,
                                                        ),
                                                      ),
                                                      dropdownBuilder: (context,
                                                          selectedItems, item) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 20.0),
                                                          child: Wrap(
                                                            children: [
                                                              selectedItems !=
                                                                      null
                                                                  ? Text(
                                                                      selectedItems,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12),
                                                                    )
                                                                  : const Text(
                                                                      "يوم الميلاد",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              10),
                                                                    ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      mode: Mode.BOTTOM_SHEET,
                                                      items: const [
                                                        '1',
                                                        '2',
                                                        '3',
                                                        '4',
                                                        '5',
                                                        '6',
                                                        '7',
                                                        '8',
                                                        '9',
                                                        '10',
                                                        '11',
                                                        '12',
                                                        '13',
                                                        '14',
                                                        '15',
                                                        '16',
                                                        '17',
                                                        '18',
                                                        '19',
                                                        '20',
                                                        '21',
                                                        '22',
                                                        '23',
                                                        '24',
                                                        '25',
                                                        '26',
                                                        '27',
                                                        '28',
                                                        '29',
                                                        '30',
                                                        '31',
                                                      ],
                                                      dropdownSearchDecoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 0),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                      ),
                                                      showSearchBox: false,
                                                      popupItemBuilder:
                                                          _customPopupItemBuilderExample,
                                                      searchFieldProps:
                                                          TextFieldProps(
                                                        textAlign:
                                                            TextAlign.right,
                                                        cursorColor:
                                                            Colors.blue,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                            const InputDecoration(
                                                          fillColor:
                                                              Colors.black54,
                                                          hoverColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(0,
                                                                      0, 20, 0),
                                                          label: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                  "ابحث هنا")),
                                                        ),
                                                      ),
                                                      popupBackgroundColor:
                                                          Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: daysColor,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                height: 31,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Center(
                                                    child:
                                                        DropdownSearch<String>(
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          dropdownValueMonth =
                                                              newValue ?? "";

                                                          print(
                                                              dropdownValueMonth);
                                                        });
                                                      },
                                                      dropDownButton:
                                                          Visibility(
                                                        visible: false,
                                                        child: Icon(
                                                          Icons.savings_sharp,
                                                          size: 2,
                                                        ),
                                                      ),
                                                      dropdownBuilder: (context,
                                                          selectedItems, item) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 20.0),
                                                          child: Wrap(
                                                            children: [
                                                              selectedItems !=
                                                                      null
                                                                  ? Text(
                                                                      selectedItems,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12),
                                                                    )
                                                                  : const Text(
                                                                      "شهر الميلاد",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              10),
                                                                    ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      mode: Mode.BOTTOM_SHEET,
                                                      items: const [
                                                        '1',
                                                        '2',
                                                        '3',
                                                        '4',
                                                        '5',
                                                        '6',
                                                        '7',
                                                        '8',
                                                        '9',
                                                        '10',
                                                        '11',
                                                        '12'
                                                      ],
                                                      dropdownSearchDecoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 0),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                      ),
                                                      showSearchBox: false,
                                                      popupItemBuilder:
                                                          _customPopupItemBuilderExample,
                                                      searchFieldProps:
                                                          TextFieldProps(
                                                        textAlign:
                                                            TextAlign.right,
                                                        cursorColor:
                                                            Colors.blue,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                            const InputDecoration(
                                                          fillColor:
                                                              Colors.black54,
                                                          hoverColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(0,
                                                                      0, 20, 0),
                                                          label: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                  "ابحث هنا")),
                                                        ),
                                                      ),
                                                      popupBackgroundColor:
                                                          Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: yearsColor, width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          height: 31,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Center(
                                              child: DropdownSearch<String>(
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropdownValueYear =
                                                        newValue ?? "";

                                                    print(dropdownValueYear);
                                                  });
                                                },
                                                dropDownButton: Visibility(
                                                  visible: false,
                                                  child: Icon(
                                                    Icons.savings_sharp,
                                                    size: 2,
                                                  ),
                                                ),
                                                dropdownBuilder: (context,
                                                    selectedItems, item) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20.0),
                                                    child: Wrap(
                                                      children: [
                                                        selectedItems != null
                                                            ? Text(
                                                                selectedItems,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            : const Text(
                                                                "سنة الميلاد",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                mode: Mode.BOTTOM_SHEET,
                                                items: const [
                                                  '1969',
                                                  '1970',
                                                  '1971',
                                                  '1972',
                                                  '1973',
                                                  '1974',
                                                  '1975',
                                                  '1976',
                                                  '1977',
                                                  '1978',
                                                  '1979',
                                                  '1980',
                                                  '1981',
                                                  '1982',
                                                  '1983',
                                                  '1984',
                                                  '1985',
                                                  '1986',
                                                  '1987',
                                                  '1988',
                                                  '1989',
                                                  '1990',
                                                  '1991',
                                                  '1992',
                                                  '1993',
                                                  '1994',
                                                  '1995',
                                                  '1996',
                                                  '1998',
                                                  '1999',
                                                  '2000',
                                                ],
                                                dropdownSearchDecoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                                ),
                                                showSearchBox: false,
                                                popupItemBuilder:
                                                    _customPopupItemBuilderExample,
                                                searchFieldProps:
                                                    TextFieldProps(
                                                  textAlign: TextAlign.right,
                                                  cursorColor: Colors.blue,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  decoration:
                                                      const InputDecoration(
                                                    fillColor: Colors.black54,
                                                    hoverColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.white),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 20, 0),
                                                    label: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child:
                                                            Text("ابحث هنا")),
                                                  ),
                                                ),
                                                popupBackgroundColor:
                                                    Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                        child: Text("أرقام أجنبية تبــدأ ب 07*",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, bottom: 15, top: 5),
                                        child: SizedBox(
                                          height: 31.15,
                                          child: TextField(
                                            onChanged: (text) {
                                              setState(() {
                                                disableCodeVerify();
                                              });
                                            },
                                            controller: phoneNo,
                                            keyboardType: TextInputType.phone,
                                            textInputAction:
                                                TextInputAction.done,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                onTap: () async {
                                                  if (disableCodeVerify()) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                content: Text(
                                                                    "الرجاء ادخال رقم الهاتف")));
                                                  } else {
                                                    startTimer();
                                                    _codeVerifyDialog();
                                                    String phone = phoneNo.text
                                                        .substring(1);
                                                    await _auth
                                                        .verifyPhoneNumber(
                                                            phoneNumber:
                                                                "+962$phone",
                                                            verificationCompleted:
                                                                (phoneAuthCredential) async {
                                                              //signInWithPhoneAuthCredential(phoneAuthCredential);
                                                            },
                                                            verificationFailed:
                                                                (verificationFailed) async {
                                                              // ignore: deprecated_member_use
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(SnackBar(
                                                                      content: Text(
                                                                          verificationFailed.message ??
                                                                              "error")));
                                                            },
                                                            codeSent:
                                                                (verificationId,
                                                                    resendingToken) async {
                                                              setState(() {
                                                                this.verificationId =
                                                                    verificationId;
                                                              });
                                                            },
                                                            codeAutoRetrievalTimeout:
                                                                (verificationId) async {
                                                              setState(() {
                                                                _verificationCode =
                                                                    verificationId;
                                                              });
                                                            },
                                                            timeout:
                                                                const Duration(
                                                                    seconds:
                                                                        60));
                                                  }
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  margin: const EdgeInsets.only(
                                                      top: 5,
                                                      bottom: 5,
                                                      left: 5),
                                                  decoration: BoxDecoration(
                                                    color: disableCodeVerify()
                                                        ? AppColors.greyColor
                                                        : AppColors
                                                            .secondaryColor,
                                                    border: Border.all(
                                                        color: disableCodeVerify()
                                                            ? AppColors
                                                                .greyColor
                                                            : AppColors
                                                                .secondaryColor,
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "تأكيد رقم الهاتف",
                                                      style: TextStyle(
                                                          color: disableCodeVerify()
                                                              ? AppColors
                                                                  .secondaryColor
                                                              : AppColors
                                                                  .primaryColor,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: phoneNoColor,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: phoneNoColor,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              labelStyle: TextStyle(
                                                  color: AppColors.greyColor,
                                                  fontSize: 14),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      right: 30.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              labelText: "رقم الهاتف",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                                            Text("الجنس",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: sexColor,
                                                )),
                                            GestureDetector(
                                              onTap: () {
                                                _shareInfoDialog();
                                              },
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Icon(Icons.share,
                                                      size: 15,
                                                      color: AppColors
                                                          .secondaryColor)),
                                            ),
                                          ],
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
                                            itemCount: sexType.length,
                                            itemBuilder:
                                                (BuildContext ctx, int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    for (var element
                                                        in sexType) {
                                                      element.active = false;
                                                    }
                                                    sexType[index].active =
                                                        true;
                                                    sexTypeSelection = true;
                                                  });
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 12.4,
                                                      width: 12.4,
                                                      decoration: BoxDecoration(
                                                        color: sexType[index]
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
                                                      sexType[index].name,
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
                                          "الحالة الإجتماعية",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: socialColor),
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
                                            itemCount: socialStatus.length,
                                            itemBuilder:
                                                (BuildContext ctx, int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    for (var element
                                                        in socialStatus) {
                                                      element.active = false;
                                                    }
                                                    socialStatus[index].active =
                                                        true;
                                                    socialSelection = true;
                                                  });
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 12.4,
                                                      width: 12.4,
                                                      decoration: BoxDecoration(
                                                        color: socialStatus[
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
                                                      socialStatus[index].name,
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
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 20.0, bottom: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: nationalityColor,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          height: 31,
                                          width: double.infinity,
                                          child: DropdownSearch<String>(
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownValueNationality =
                                                    newValue ?? "";

                                                print(dropdownValueNationality);
                                              });
                                            },
                                            dropDownButton: GestureDetector(
                                                onTap: () {
                                                  _shareInfoDialog();
                                                },
                                                child: const Icon(
                                                  Icons.share,
                                                  color: Colors.white,
                                                  size: 15,
                                                )),
                                            dropdownBuilder:
                                                (context, selectedItems, item) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0),
                                                child: Wrap(
                                                  children: [
                                                    selectedItems != null
                                                        ? Text(
                                                            selectedItems,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13),
                                                          )
                                                        : const Text(
                                                            "الجنسية",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 13),
                                                          ),
                                                  ],
                                                ),
                                              );
                                            },
                                            mode: Mode.BOTTOM_SHEET,
                                            items: const [
                                              "اردني",
                                              "غير اردني",
                                            ],
                                            dropdownSearchDecoration:
                                                const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            ),
                                            showSearchBox: false,
                                            popupItemBuilder:
                                                _customPopupItemBuilderExample,
                                            searchFieldProps: TextFieldProps(
                                              textAlign: TextAlign.right,
                                              cursorColor: Colors.blue,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              decoration: const InputDecoration(
                                                fillColor: Colors.black54,
                                                hoverColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.white),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        0, 0, 20, 0),
                                                label: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text("ابحث هنا")),
                                              ),
                                            ),
                                            popupBackgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                                        child: Text("أرقام أجنبية 10*",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, bottom: 25),
                                        child: SizedBox(
                                          height: 31.15,
                                          child: TextFormField(
                                            maxLines: 1,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: idNumber,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: idNumberColor,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: idNumberColor,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              labelStyle: TextStyle(
                                                  color: AppColors.greyColor,
                                                  fontSize: 14),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      right: 30),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              labelText: "الرقم الوطني",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                                        child: Text("مكان السكن",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, bottom: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: homeListColor,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                height: 31,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20, top: 5.0),
                                                  child: DropdownSearch<String>(
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownValueHome =
                                                            newValue ?? "";
                                                      });
                                                    },
                                                    dropDownButton:
                                                        const Visibility(
                                                      visible: false,
                                                      child: Icon(
                                                        Icons.savings_sharp,
                                                        size: 2,
                                                      ),
                                                    ),
                                                    dropdownBuilder: (context,
                                                        selectedItems, item) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0),
                                                        child: Wrap(
                                                          children: [
                                                            selectedItems !=
                                                                    null
                                                                ? Text(
                                                                    selectedItems,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12),
                                                                  )
                                                                : const Text(
                                                                    "المحافظة",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            11),
                                                                  ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    mode: Mode.BOTTOM_SHEET,
                                                    items: const [
                                                      "عمان",
                                                      "الزرقاء",
                                                      "البلقاء",
                                                      "مادبا",
                                                      "عجلون",
                                                      "جرش",
                                                      "اربد",
                                                      "المفرق",
                                                      "العقبة",
                                                      "معان",
                                                      "الطفيلة",
                                                      "الكرك",
                                                    ],
                                                    dropdownSearchDecoration:
                                                        const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                    ),
                                                    showSearchBox: false,
                                                    popupItemBuilder:
                                                        _customPopupItemBuilderExample,
                                                    searchFieldProps:
                                                        TextFieldProps(
                                                      textAlign:
                                                          TextAlign.right,
                                                      cursorColor: Colors.blue,
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                      decoration:
                                                          const InputDecoration(
                                                        fillColor:
                                                            Colors.black54,
                                                        hoverColor:
                                                            Colors.white,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 20, 0),
                                                        label: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                                "ابحث هنا")),
                                                      ),
                                                    ),
                                                    popupBackgroundColor:
                                                        Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: SizedBox(
                                                height: 31.15,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  controller: area,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: areaColor,
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: areaColor,
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                    labelStyle: TextStyle(
                                                        color:
                                                            AppColors.greyColor,
                                                        fontSize: 14),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            right: 30),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                    labelText: "الحي",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                    _changeColor();
                    if (checkLanguageArea() &&
                        checkLanguageFirstName() &&
                        checkLanguageSecondName() &&
                        checkLanguageThirdName() &&
                        checkLanguageFinalName()) {
                      setState(() {
                        nameLanguageColor = AppColors.secondaryColor;
                      });
                      if (enterCode == true) {
                        attachSelectItem();
                        Get.to(const RelativesInformation());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                "الرجاء ادخال رمز التحقق لرقم الهاتف الذي ادخلته")));
                      }
                    } else {
                      setState(() {
                        nameLanguageColor = Colors.red;
                      });
                    }
                  } else {
                    _changeColor();
                  }
                },
                child: PrimaryButton(
                  title: "التالي",
                  textColor: _validation()
                      ? AppColors.primaryColor
                      : AppColors.secondaryColor,
                  textSize: 14,
                  fillColor: _validation()
                      ? AppColors.secondaryColor
                      : AppColors.greyColor,
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
    );
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, String? item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              item ?? 'Error',
              style: const TextStyle(color: Colors.black),
            )),
      ),
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

  Future<void> _codeVerifyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: 210.19,
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
                  SizedBox(
                    height: 35,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          _disableButton();
                        });
                      },
                      controller: verifyCode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: AppColors.primaryColor),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 1.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 1.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelStyle: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.only(right: 30.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        label: SizedBox(
                          width: 110,
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: AppColors.primaryColor,
                                size: 15,
                              ),
                              const SizedBox(width: 15),
                              const Text(
                                "رمز التحقق",
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: GestureDetector(
                          onTap: resendCode == true
                              ? () async {
                                  startTimer();

                                  String phone = phoneNo.text.substring(1);
                                  await _auth.verifyPhoneNumber(
                                      phoneNumber: "+962$phone",
                                      verificationCompleted:
                                          (phoneAuthCredential) async {
                                        //signInWithPhoneAuthCredential(phoneAuthCredential);
                                      },
                                      verificationFailed:
                                          (verificationFailed) async {
                                        // ignore: deprecated_member_use
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(verificationFailed
                                                        .message ??
                                                    "error")));
                                      },
                                      codeSent:
                                          (verificationId,
                                              resendingToken) async {
                                        setState(() {
                                          this.verificationId = verificationId;
                                        });
                                      },
                                      codeAutoRetrievalTimeout:
                                          (verificationId) async {
                                        setState(() {
                                          _verificationCode = verificationId;
                                        });
                                      },
                                      timeout: const Duration(seconds: 60));
                                }
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              "الرجاء ادخال رمز التحقق الذي تم ارساله لرقم هاتفك")));
                                },
                          child: Container(
                            height: 25.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.57),
                                border: Border.all(
                                    width: 1,
                                    color: resendCode == false
                                        ? Colors.grey.shade600
                                        : AppColors.primaryColor),
                                color: resendCode == false
                                    ? Colors.grey.shade600
                                    : AppColors.primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                              child: Center(
                                child: Text(
                                  "ارسال رمز التحقق",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.secondaryColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                        flex: 4,
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (_disableButton() == false) {
                          PhoneAuthCredential phoneAuthCredential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId,
                                  smsCode: verifyCode.text);

                          signInWithPhoneAuthCredential(phoneAuthCredential);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("الرجاء ادخال رمز التحقق")));
                        }
                      },
                      child: PrimaryButton(
                        title: "تأكيد",
                        textColor: AppColors.secondaryColor,
                        textSize: 14,
                        fillColor: _disableButton()
                            ? Colors.grey.shade600
                            : AppColors.primaryColor,
                        borderColor: _disableButton()
                            ? Colors.grey.shade600
                            : AppColors.primaryColor,
                        height: 31.15,
                        width: 86.86,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
