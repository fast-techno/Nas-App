import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas_app/compnenets/password_icon.dart';
import 'package:nas_app/compnenets/secondary_button.dart';
import 'package:nas_app/providers/forgot_password_api.dart';
import 'package:nas_app/screens/login_page.dart';
import 'package:nas_app/utils/app_colors.dart';

class UpdatePassword extends StatefulWidget {
  UpdatePassword({Key? key, required this.phoneNo}) : super(key: key);

  String phoneNo;

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController reConfirmPassword = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _disableButton() {
    if (newPassword.text.length > 3) {
      if (newPassword.text == reConfirmPassword.text) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
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
                Container(
                    height: 129,
                    width: 129,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                ExactAssetImage('assets/images/main_logo.png'),
                            fit: BoxFit.fill))),
                const SizedBox(height: 30),
                Text("نسيت كلمة المرور",
                    style: Theme.of(context).textTheme.headline1),
                const SizedBox(height: 50),
                SizedBox(
                  height: 45,
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        _disableButton();
                      });
                    },
                    controller: newPassword,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    obscureText: _obscurePassword,
                    style: TextStyle(color: AppColors.secondaryColor),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: PasswordIcon(obscureText: _obscurePassword)),
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
                              "كملة المرور الجديدة",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 45,
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        _disableButton();
                      });
                    },
                    controller: reConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: _obscureConfirmPassword,
                    style: TextStyle(color: AppColors.secondaryColor),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          child: PasswordIcon(
                              obscureText: _obscureConfirmPassword)),
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
                        width: 140,
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: AppColors.secondaryColor,
                              size: 18,
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              "اعادة كلمة المرور",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    if (_disableButton()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("كلمة المرور غير مطابقة")));
                    } else {
                      ForgotPasswordApi()
                          .changePassword(
                              widget.phoneNo,
                              newPassword.text.toString(),
                              reConfirmPassword.text.toString())
                          .then((value) => print(value['status']));
                      Get.offAll(const LoginPage());
                    }
                  },
                  child: SecondaryButton(
                    title: "تأكيد",
                    fillColor: _disableButton()
                        ? AppColors.greyColor
                        : AppColors.secondaryColor,
                    textColor: _disableButton()
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
}
