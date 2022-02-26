import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/screens/interview_date.dart';
import 'package:nas_app/utils/app_colors.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RelativesInformationContainer extends StatefulWidget {
  RelativesInformationContainer(
      {Key? key,
      required this.title,
      required this.spaceTitle,
      required this.heightContainer})
      : super(key: key);
  String title;
  double spaceTitle;
  double heightContainer;

  @override
  State<RelativesInformationContainer> createState() =>
      _RelativesInformationContainerState();
}

class _RelativesInformationContainerState
    extends State<RelativesInformationContainer> {
  GetStorage signUpBox = GetStorage();

  TextEditingController firstRelative = TextEditingController();
  TextEditingController firstPhoneNoRelative = TextEditingController();
  TextEditingController secondRelative = TextEditingController();
  TextEditingController secondPhoneNoRelative = TextEditingController();

  Color firstRelativeColor = AppColors.greyColor;
  Color firstPhoneNoRelativeColor = AppColors.greyColor;
  Color firstDropDownRelativeColor = AppColors.greyColor;
  Color secondRelativeColor = AppColors.greyColor;
  Color secondDropDownRelativeColor = AppColors.greyColor;
  Color secondPhoneNoRelativeColor = AppColors.greyColor;
  Color firstLanguageColor = AppColors.secondaryColor;
  Color secondLanguageColor = AppColors.secondaryColor;

  List<String> realtiveOne = <String>['اخ', 'اب', 'ام', 'قريب'];
  String? dropdownValuerealtiveOne;
  List<String> realtiveTwo = <String>['اخ', 'اب', 'ام', 'قريب'];
  String? dropdownValuerealtiveTwo;

  List<String> omar = [];

  bool checkLanguageFirstRelative() {
    for (int i = 0; i < firstRelative.text.length; i++) {
      if (firstRelative.text[i]
          .contains(RegExp(r'^[a-zA-Z0-9_\-?=@^,*/{}|\.;+]+$'))) {
        setState(() {
          firstLanguageColor = Colors.red;
        });
        return false;
      }
    }
    setState(() {
      firstLanguageColor =  AppColors.secondaryColor;
    });
    return true;
  }

  bool checkLanguageSecondRelative() {
    for (int i = 0; i < secondRelative.text.length; i++) {
      if (secondRelative.text[i]
          .contains(RegExp(r'^[a-zA-Z0-9_\-?=@^,*/{}|\.;+]+$'))) {
        setState(() {
          secondLanguageColor = Colors.red;
        });
        return false;
      }
    }
    setState(() {
      secondLanguageColor =  AppColors.secondaryColor;
    });
    return true;
  }

  void attachSelectItem() {
    print("********************************");
    if (firstRelative.text != null) {
      signUpBox.write('first_relative', firstRelative.text);
      print(firstRelative.text);
    }
    print("********************************");
    if (firstPhoneNoRelative.text != null) {
      signUpBox.write('first_relative_phone', firstPhoneNoRelative.text);
      print(firstPhoneNoRelative.text);
    }
    print("********************************");
    if (dropdownValuerealtiveOne != null) {
      signUpBox.write('first_relationship', dropdownValuerealtiveOne);
      print(dropdownValuerealtiveOne);
    }
    ;
    print("********************************");
    if (secondRelative.text != null) {
      signUpBox.write('second_relative', secondRelative.text);
      print(secondRelative.text);
    }
    print("********************************");
    if (secondPhoneNoRelative.text != null) {
      signUpBox.write('second_relative_phone', secondPhoneNoRelative.text);
      print(secondPhoneNoRelative.text);
    }
    print("********************************");
    if (dropdownValuerealtiveTwo != null) {
      signUpBox.write('second_relationship', dropdownValuerealtiveTwo);
      print(dropdownValuerealtiveTwo);
    }
    ;
  }

  bool _validation() {
    print("firstRelative.text.isNotEmpty");
    print(firstRelative.text.isNotEmpty);

    print("firstPhoneNoRelative.text.length == 10 && firstPhoneNoRelative.text.startsWith(07)");
    print(firstPhoneNoRelative.text.length == 10 &&
        firstPhoneNoRelative.text.startsWith("07"));

    print("dropdownValuerealtiveOne != null");
    print(dropdownValuerealtiveOne != null);

    print("secondRelative.text.isNotEmpty");
    print(secondRelative.text.isNotEmpty);

    print("secondPhoneNoRelative.text.length == 10 && secondPhoneNoRelative.text.startsWith(07)");
    print(secondPhoneNoRelative.text.length == 10 &&
        secondPhoneNoRelative.text.startsWith("07"));

    print("dropdownValuerealtiveTwo != null");
    print(dropdownValuerealtiveTwo != null);

    return (firstRelative.text.isNotEmpty &&
        firstPhoneNoRelative.text.length == 10 &&
        firstPhoneNoRelative.text.startsWith("07") &&
        dropdownValuerealtiveOne != null &&
        secondRelative.text.isNotEmpty &&
        secondPhoneNoRelative.text.length == 10 &&
        secondPhoneNoRelative.text.startsWith("07") &&
        dropdownValuerealtiveTwo != null);
  }

  void _changeColor() {
    firstRelative.text.isEmpty
        ? setState(() {
            firstRelativeColor = Colors.red;
          })
        : setState(() {
            firstRelativeColor = AppColors.greyColor;
          });

    firstPhoneNoRelative.text.length == 10 &&
            firstPhoneNoRelative.text.startsWith("07")
        ? setState(() {
            firstPhoneNoRelativeColor = AppColors.greyColor;
          })
        : setState(() {
            firstPhoneNoRelativeColor = Colors.red;
          });

    dropdownValuerealtiveOne == null
        ? setState(() {
            firstDropDownRelativeColor = Colors.red;
          })
        : setState(() {
            firstDropDownRelativeColor = AppColors.greyColor;
          });

    secondRelative.text.isEmpty
        ? setState(() {
            secondRelativeColor = Colors.red;
          })
        : setState(() {
            secondRelativeColor = AppColors.greyColor;
          });

    secondPhoneNoRelative.text.length == 10 &&
            secondPhoneNoRelative.text.startsWith("07")
        ? setState(() {
            secondPhoneNoRelativeColor = AppColors.greyColor;
          })
        : setState(() {
            secondPhoneNoRelativeColor = Colors.red;
          });

    dropdownValuerealtiveTwo != null
        ? setState(() {
            secondDropDownRelativeColor = AppColors.greyColor;
          })
        : setState(() {
            secondDropDownRelativeColor = Colors.red;
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text("القريب الأول",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1),
                                          ),
                                          Text("باللغة العربية فقط*",
                                              style: TextStyle(color: firstLanguageColor, fontSize: 14)),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, bottom: 10),
                                        child: SizedBox(
                                          height: 31.15,
                                          child: TextFormField(
                                            onChanged: (text){
                                              _validation();
                                            },
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: firstRelative,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: firstRelativeColor,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: firstRelativeColor,
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
                                              labelText: "الاسم",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, bottom: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: firstDropDownRelativeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        height: 31,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30.0, top: 2),
                                          child: DropdownSearch<String>(
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownValuerealtiveOne =
                                                    newValue ?? "";
                                                  _validation();
                                                print(dropdownValuerealtiveOne);
                                              });
                                            },
                                            dropDownButton: Visibility(
                                              visible: false,
                                              child: Icon(
                                                Icons.savings_sharp,
                                                size: 2,
                                              ),
                                            ),
                                            dropdownBuilder:
                                                (context, selectedItems, item) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 1.0),
                                                child: Wrap(
                                                  children: [
                                                    selectedItems != null
                                                        ? Text(
                                                            selectedItems,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          )
                                                        : Text(
                                                            "الصلة",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .greyColor,
                                                                fontSize: 13),
                                                          ),
                                                  ],
                                                ),
                                              );
                                            },
                                            mode: Mode.BOTTOM_SHEET,
                                            items: const [
                                              'أب',
                                              'أم',
                                              'أخ',
                                              'قريب',
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
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: Text(
                                                  "أرقام أجنبية تبدأ ب 07*",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                            ),
                                            SizedBox(
                                              height: 31.15,
                                              child: TextField(
                                                onChanged: (text){
                                                  _validation();
                                                },
                                                controller:
                                                    firstPhoneNoRelative,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.done,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            firstPhoneNoRelativeColor,
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            firstPhoneNoRelativeColor,
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
                                                          right: 30.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  labelText: "رقم الهاتف",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text("القريب الثاني",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1),
                                          ),
                                          Text("باللغة العربية فقط*",
                                               style: TextStyle(color: secondLanguageColor, fontSize: 14)),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, bottom: 10),
                                        child: SizedBox(
                                          height: 31.15,
                                          child: TextFormField(
                                            onChanged: (text){
                                              _validation();
                                            },
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: secondRelative,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: secondRelativeColor,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: secondRelativeColor,
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
                                              labelText: "الاسم",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, bottom: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  secondDropDownRelativeColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        height: 31,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30.0, top: 2),
                                          child: DropdownSearch<String>(
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownValuerealtiveTwo =
                                                    newValue ?? "";
                                                  _validation();
                                                print(dropdownValuerealtiveTwo);
                                              });
                                            },
                                            dropDownButton: Visibility(
                                              visible: false,
                                              child: Icon(
                                                Icons.savings_sharp,
                                                size: 2,
                                              ),
                                            ),
                                            dropdownBuilder:
                                                (context, selectedItems, item) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 1.0),
                                                child: Wrap(
                                                  children: [
                                                    selectedItems != null
                                                        ? Text(
                                                            selectedItems,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          )
                                                        : Text(
                                                            "الصلة",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .greyColor,
                                                                fontSize: 13),
                                                          ),
                                                  ],
                                                ),
                                              );
                                            },
                                            mode: Mode.BOTTOM_SHEET,
                                            items: const [
                                              'أب',
                                              'أم',
                                              'أخ',
                                              'قريب',
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
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: Text(
                                                  "أرقام أجنبية تبدأ ب 07*",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                            ),
                                            SizedBox(
                                              height: 31.15,
                                              child: TextField(
                                                onChanged: (text){
                                                  _validation();
                                                },
                                                controller:
                                                    secondPhoneNoRelative,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.done,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            secondPhoneNoRelativeColor,
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            secondPhoneNoRelativeColor,
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
                                                          right: 30.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  labelText: "رقم الهاتف",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30)
                          ],
                        ),
                      ),
                    )),
              ),
              Positioned(
                top: 9,
                right: 55,
                child: Container(
                  height: 9,
                  width: widget.spaceTitle,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              Positioned(
                top: -3,
                right: 70,
                child: Text(widget.title,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              Positioned(
                top: 5,
                right: 45,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
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
                    if(checkLanguageFirstRelative() && checkLanguageSecondRelative()){
                      attachSelectItem();
                      Get.to(const InterviewDate());
                    }
                  } else {
                    () {};
                  }
                },
                child: PrimaryButton(
                  title: "التالي",
                  textColor: AppColors.primaryColor,
                  textSize: 14,
                  fillColor:  AppColors.secondaryColor,
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
              item ?? 'omar',
              style: const TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
