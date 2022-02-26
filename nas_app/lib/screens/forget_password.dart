import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_app/compnenets/main_logo.dart';
import 'package:nas_app/compnenets/secondary_button.dart';
import 'package:nas_app/providers/forgot_password_api.dart';
import 'package:nas_app/screens/update_password.dart';
import 'package:nas_app/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  Timer? _timer;
  int _start = 30;
  bool resendCode = false;
  String? _verificationCode;
  late String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;

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

  TextEditingController phoneNo = TextEditingController();
  TextEditingController verifyCode = TextEditingController();

  bool _disableVerifyCode() {
    if (phoneNo.text.length == 10 && phoneNo.text.startsWith("07")) {
      return false;
    } else {
      return true;
    }
  }

  bool _disableBackVerifyCode() {
    if (verifyCode.text.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool _disableSubmitButton() {
    if (!_disableVerifyCode() && !_disableBackVerifyCode()) {
      return false;
    } else {
      return true;
    }
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        ForgotPasswordApi()
            .forgotPassword(phoneNo.text.toString())
            .then((value) {
          if (value['status']) {
            Get.to(UpdatePassword(phoneNo: phoneNo.text.toString()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text("رقم الهاتف غير مسجل كمستخدم")));
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      _scaffoldKey.currentState
          // ignore: deprecated_member_use
          ?.showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text("رمز التحقق غير صحيح")));
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MainLogo(),
                const SizedBox(height: 30),
                Text("نسيت كلمة المرور",
                    style: Theme.of(context).textTheme.headline1),
                const SizedBox(height: 50),
                SizedBox(
                  height: 45,
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        _disableVerifyCode();
                      });
                    },
                    controller: phoneNo,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: AppColors.secondaryColor),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.secondaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.secondaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelStyle: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.only(right: 30.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      label: SizedBox(
                        width: 160,
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: AppColors.secondaryColor,
                              size: 18,
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              "رقم الهاتف المدير",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        startTimer();

                        String phone = phoneNo.text.substring(1);
                        await _auth.verifyPhoneNumber(
                            phoneNumber: "+962$phone",
                            verificationCompleted: (phoneAuthCredential) async {
                              //signInWithPhoneAuthCredential(phoneAuthCredential);
                            },
                            verificationFailed: (verificationFailed) async {
                              // ignore: deprecated_member_use
                              _scaffoldKey.currentState?.showSnackBar(SnackBar(
                                  content: Text(
                                      verificationFailed.message ?? "error")));
                            },
                            codeSent: (verificationId, resendingToken) async {
                              setState(() {
                                this.verificationId = verificationId;
                              });
                            },
                            codeAutoRetrievalTimeout: (verificationId) async {
                              setState(() {
                                _verificationCode = verificationId;
                              });
                            },
                            timeout: const Duration(seconds: 60));
                      },
                      child: _verifyContainer(
                          "ارسال رمز التحقق",
                          _disableVerifyCode() == true
                              ? AppColors.greyColor
                              : AppColors.secondaryColor,
                          _disableVerifyCode() == false
                              ? AppColors.primaryColor
                              : AppColors.secondaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 45,
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        _disableBackVerifyCode();
                        _verificationCode = verifyCode.text;
                      });
                    },
                    controller: verifyCode,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: AppColors.secondaryColor),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.secondaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.secondaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelStyle: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.only(right: 30.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      label: SizedBox(
                        width: 120,
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: AppColors.secondaryColor,
                              size: 18,
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              "رمز التحقق",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    GestureDetector(
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
                                    _scaffoldKey.currentState?.showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                verificationFailed.message ??
                                                    "error")));
                                  },
                                  codeSent:
                                      (verificationId, resendingToken) async {
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
                      child: _verifyContainer(
                          "اعادة ارسال رمز التحقق",
                          resendCode == false
                              ? AppColors.greyColor
                              : AppColors.secondaryColor,
                          resendCode == true
                              ? AppColors.primaryColor
                              : AppColors.secondaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
                    if (_disableSubmitButton()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("الرجاء ادخال رمز التحقق")));
                    } else {
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: verifyCode.text);

                      signInWithPhoneAuthCredential(phoneAuthCredential);
                    }
                  },
                  child: SecondaryButton(
                    title: "تأكيد",
                    fillColor: _disableSubmitButton()
                        ? AppColors.greyColor
                        : AppColors.secondaryColor,
                    textColor: _disableSubmitButton()
                        ? AppColors.secondaryColor
                        : AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _verifyContainer(String title, Color fillColor, Color textColor) {
    return Container(
      height: 31.15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.57),
          border: Border.all(width: 1, color: Colors.white),
          color: fillColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 13, color: textColor),
          ),
        ),
      ),
    );
  }
}
