import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_app/compnenets/password_icon.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/screens/confirmation.dart';
import 'package:nas_app/utils/app_colors.dart';
import 'package:nas_app/utils/styling.dart';

class SignUpPassword extends StatefulWidget {
  const SignUpPassword({Key? key}) : super(key: key);

  @override
  _SignUpPasswordState createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  GetStorage signUpBox = GetStorage();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  Color newPasswordColor = AppColors.greyColor;
  Color confirmPasswordColor = AppColors.greyColor;

  bool disableButton() {
    if ((newPassword.text.length > 3) &&
        (newPassword.text == confirmPassword.text)) {
      return false;
    } else {
      return true;
    }
  }

  bool _validation() {
    return ((newPassword.text.length > 3) &&
        (newPassword.text == confirmPassword.text));
  }

  void _changeColor() {
    (newPassword.text.length > 3) && (newPassword.text == confirmPassword.text)
        ? setState(() {
            newPasswordColor = AppColors.secondaryColor;
            confirmPasswordColor = AppColors.secondaryColor;
          })
        : setState(() {
            newPasswordColor = Colors.red;
            confirmPasswordColor = Colors.red;
          });
  }

  void attachSelectItem() {
    if((newPassword.text.length > 3) && (newPassword.text == confirmPassword.text)){
      signUpBox.write('password', newPassword.text);
      print(signUpBox.read('password'));
    }
  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpBox.read('phone');
    print(signUpBox.read('phone'));
    phoneNo.text = signUpBox.read('phone');
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
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Center(
                  child: Container(
                    width: 129.67,
                    height: 127.92,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage(
                                'assets/images/main_logo.png'))),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 90,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text("كلمة المرور",
                                  style: Theme.of(context).textTheme.headline1),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              onChanged: (text) {
                                setState(() {
                                  disableButton();
                                });
                              },
                              controller: phoneNo,
                              enabled: false,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              style: Styling.labelTextField,
                              decoration: InputDecoration(
                                focusedBorder: Styling.focusedBorderTextField,
                                enabledBorder: Styling.enabledBorderTextField,
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.greyColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                labelStyle: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.bold),
                                contentPadding:
                                    const EdgeInsets.only(right: 30.0),
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
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              onChanged: (text) {
                                setState(() {
                                  disableButton();
                                });
                              },
                              controller: newPassword,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              obscureText: _obscureNewPassword,
                              style: TextStyle(color: AppColors.secondaryColor),
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureNewPassword =
                                            !_obscureNewPassword;
                                      });
                                    },
                                    child: PasswordIcon(
                                        obscureText: _obscureNewPassword)),
                                focusedBorder: Styling.focusedBorderTextField,
                                enabledBorder: Styling.enabledBorderTextField,
                                labelStyle: Styling.labelTextField,
                                contentPadding:
                                    const EdgeInsets.only(right: 30.0),
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
                                  disableButton();
                                });
                              },
                              controller: confirmPassword,
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
                                focusedBorder: Styling.focusedBorderTextField,
                                enabledBorder: Styling.enabledBorderTextField,
                                labelStyle: Styling.labelTextField,
                                contentPadding:
                                    const EdgeInsets.only(right: 30.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                label: SizedBox(
                                  width: 150,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: AppColors.secondaryColor,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 15),
                                      const Text(
                                        "أعادة كلمة المرور",
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _changeColor();
                                if(_validation()){
                                  attachSelectItem();
                                  Get.to(const Confirmation());
                                }
                              },
                              child: PrimaryButton(
                                title: "تأكيد",
                                textColor: disableButton()
                                    ? AppColors.secondaryColor
                                    : AppColors.primaryColor,
                                textSize: 14,
                                fillColor: disableButton()
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
