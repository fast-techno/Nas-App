import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_app/Model/login_model.dart';
import 'package:nas_app/compnenets/label_text_field.dart';
import 'package:nas_app/compnenets/main_logo.dart';
import 'package:nas_app/compnenets/password_icon.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/providers/login_api.dart';
import 'package:nas_app/screens/forget_password.dart';
import 'package:nas_app/screens/home_page.dart';
import 'package:nas_app/screens/registration_request.dart';
import 'package:nas_app/utils/app_colors.dart';
import 'package:nas_app/utils/styling.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GetStorage box = GetStorage();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  Color phoneNumberColor = AppColors.secondaryColor;
  Color passwordColor = AppColors.secondaryColor;
  bool _obscureText = true;
  late bool _saveData;

  bool disableButton() {
    if (phoneNo.text.length == 10 &&
        phoneNo.text.startsWith("07") &&
        password.text.length > 3) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box.read('auto_login') ?? box.write('auto_login', false);
    if (box.read('auto_login') == true) {
      _saveData = box.read('auto_login');
      if (_saveData == true) {
        phoneNo.text = box.read('phone_no') ?? "";
        password.text = box.read('password') ?? "";
      }
    } else {
      _saveData = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const MainLogo(),
                const SizedBox(height: 30),
                Text("دخول", style: Theme.of(context).textTheme.headline1),
                const SizedBox(height: 50),
                SizedBox(
                  height: 45,
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        disableButton();
                      });
                    },
                    controller: phoneNo,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color: AppColors.secondaryColor),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: phoneNumberColor, width: 1.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: phoneNumberColor, width: 1.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelStyle: Styling.labelTextField,
                        contentPadding: const EdgeInsets.only(right: 30.0),
                        label: LabelTextField(
                            text: "رقم هاتف المدير",
                            spaceText: 140,
                            fontSize: 15,
                            sizeIcon: 15)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        disableButton();
                      });
                    },
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: _obscureText,
                    style: TextStyle(color: AppColors.secondaryColor),
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: PasswordIcon(
                              obscureText: _obscureText,
                            )),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: passwordColor, width: 1.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: passwordColor, width: 1.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelStyle: Styling.labelTextField,
                        contentPadding: const EdgeInsets.only(right: 30.0),
                        label: LabelTextField(
                            text: "كلمة المرور",
                            spaceText: 100,
                            fontSize: 15,
                            sizeIcon: 15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _saveData = !_saveData;
                          });
                        },
                        child: Row(
                          children: [
                            _saveData
                                ? const Icon(
                                    Icons.circle,
                                    size: 20.0,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.circle_outlined,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "دخول تلقائي",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const ForgetPassword());
                        },
                        child: const Text(
                          "نسيت كلمة المرور",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          login();
                        },
                        child: PrimaryButton(
                          title: "دخول",
                          textColor: AppColors.primaryColor,
                          textSize: 17,
                          fillColor:
                              disableButton() == false
                                  ? AppColors.secondaryColor
                                  : AppColors.greyColor,
                          borderColor: Colors.white,
                          height: 45.88,
                          width: 123.6,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const RegistrationRequest());
                        },
                        child: PrimaryButton(
                          title: "سجل الآن",
                          textColor: AppColors.primaryColor,
                          textSize: 17,
                          fillColor: Colors.white,
                          borderColor: Colors.white,
                          height: 45.88,
                          width: 123.6,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void login() {
    if (disableButton()) {
      if(phoneNo.text.isEmpty || phoneNo.text.length != 10){
        setState(() {
          phoneNumberColor = Colors.red;
        });
      } else {
        setState(() {
          phoneNumberColor = AppColors.secondaryColor;
        });
      }
      if(password.text.isEmpty){
        setState(() {
          passwordColor = Colors.red;
        });
      } else {
        setState(() {
          passwordColor = AppColors.secondaryColor;
        });
      }
    } else {
      setState(() {
        phoneNumberColor = AppColors.secondaryColor;
        passwordColor = AppColors.secondaryColor;
      });
      Login log = Login();
      log.phone = phoneNo.text;
      log.password = password.text;

      box.write('auto_login', _saveData);
      LoginApi().login(log).then((value) {
        try {
          print(value['data']['token']);
        if(value['status']){
          box.write('token', value['data']['token']);
          if (box.read('auto_login') == true) {
            box.write('phone_no', phoneNo.text);
            box.write('password', password.text);
          }
          Get.to(const HomePage());
        }
        } catch (ex) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('رقم الهاتف  أو كلمة المرور غير صحيحة')));
        }
      });
    }
  }
}
