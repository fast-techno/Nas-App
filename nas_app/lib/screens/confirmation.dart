import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nas_app/Model/sign_up_model.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/compnenets/primary_container.dart';
import 'package:nas_app/providers/sign_up_api.dart';
import 'package:nas_app/screens/home_page.dart';
import 'package:nas_app/utils/app_colors.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  GetStorage signUpBox = GetStorage();
  SignUp signUp = SignUp();
  String registerConfirmation = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRegisterConfirmation();
    signUp.phone = signUpBox.read('phone').toString();
    print("phone: ${signUp.phone}");

    signUp.toldId = signUpBox.read('told_id').toString();
    print("told id: ${signUp.toldId}");

    signUp.toldValue = signUpBox.read('told_value').toString();
    print("told value: ${signUp.toldValue}");

    signUp.jobId = signUpBox.read('job_id').toString();
    print("job_id: ${signUp.jobId}");

    signUp.preferredWorkingDays =
        signUpBox.read('preferred_working_days').toString();
    print("preferred_working_days: ${signUp.preferredWorkingDays}");

    signUp.preferredWorkingTimes =
        signUpBox.read('preferred_working_times').toString();
    print("preferred_working_times: ${signUp.preferredWorkingTimes}");

    signUp.preferredWorkPeriod =
        signUpBox.read('preferred_work_period').toString();
    print("preferred_work_period: ${signUp.preferredWorkPeriod}");

    signUp.workOnOccasions = signUpBox.read('work_on_occasions').toString();
    print("work_on_occasions: ${signUp.workOnOccasions}");

    signUp.needForTransportation =
        signUpBox.read('need_for_transportation').toString();
    print("need_for_transportation: ${signUp.needForTransportation}");

    signUp.receiveDues = signUpBox.read('receive_dues').toString();
    print("receive_dues: ${signUp.receiveDues}");

    signUp.firstName = signUpBox.read('first_name').toString();
    print("first_name: ${signUp.firstName}");

    signUp.fatherName = signUpBox.read('father_name').toString();
    print("father_name: ${signUp.fatherName}");

    signUp.grandfatherName = signUpBox.read('grandfather_name').toString();
    print("grandfather_name: ${signUp.grandfatherName}");

    signUp.lastName = signUpBox.read('last_name').toString();
    print("last_name: ${signUp.lastName}");

    signUp.dayOfBirth = signUpBox.read('day_of_birth').toString();
    print("day_of_birth: ${signUp.dayOfBirth}");

    signUp.yearOfBirth = signUpBox.read('year_of_birth').toString();
    print("year_of_birth: ${signUp.yearOfBirth}");

    signUp.monthOfBirth = signUpBox.read('month_of_birth').toString();
    print("month_of_birth: ${signUp.monthOfBirth}");

    signUp.gender = signUpBox.read('gender').toString();
    print("gender: ${signUp.gender}");

    signUp.maritalStatus = signUpBox.read('marital_status').toString();
    print("marital_status: ${signUp.maritalStatus}");

    signUp.nationality = signUpBox.read('nationality').toString();
    print("nationality: ${signUp.nationality}");

    signUp.nationalityOther = signUpBox.read('nationality_other').toString();
    print("nationality_other: ${signUp.nationalityOther}");

    signUp.nationalNumber = signUpBox.read('national_number').toString();
    print("national_number: ${signUp.nationalNumber}");

    signUp.area = signUpBox.read('area').toString();
    print("area: ${signUp.area}");

    signUp.governorate = signUpBox.read('governorate').toString();
    print("governorate: ${signUp.governorate}");

    signUp.firstRelative = signUpBox.read('first_relative').toString();
    print("first_relative: ${signUp.firstRelative}");

    signUp.firstRelativePhone =
        signUpBox.read('first_relative_phone').toString();
    print("first_relative_phone: ${signUp.firstRelativePhone}");

    signUp.firstRelationship = signUpBox.read('first_relationship').toString();
    print("first_relationship: ${signUp.firstRelationship}");

    signUp.secondRelative = signUpBox.read('second_relative').toString();
    print("second_relative: ${signUp.secondRelative}");

    signUp.secondRelativePhone =
        signUpBox.read('second_relative_phone').toString();
    print("second_relative_phone: ${signUp.secondRelativePhone}");

    signUp.secondRelationship =
        signUpBox.read('second_relationship').toString();
    print("second_relationship: ${signUp.secondRelationship}");

    signUp.interviewId = signUpBox.read('interview_id').toString();
    print("interview_id: ${signUp.interviewId}");

    signUp.password = signUpBox.read('password').toString();
    print("password: ${signUp.password}");
  }


  getRegisterConfirmation() async{
    EasyLoading.show(status: "تحميل");
    await SignUpApi().getRegisterConfirmation().then((value) {
      if(value['data'] != null){
        for (var element in value['data']) {
          setState(() {
            registerConfirmation = "$registerConfirmation${element['content']}";
          });
        }
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
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
                    children: [
                      PrimaryContainer(
                        title: "تأكيد الطلب",
                        spaceTitle: 110,
                        containWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(registerConfirmation,
                                style: Theme.of(context).textTheme.headline6),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            SignUpApi().signUp(signUp).then((value) => {
                                  if (value['status'])
                                    {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const HomePage()),
                                          (route) => false)
                                    }
                                  else
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  "رقم المستخدم معرف من قبل!")))
                                    }
                                });
                          },
                          child: PrimaryButton(
                            title: "تسجيل الدخول",
                            textColor: AppColors.primaryColor,
                            textSize: 14,
                            fillColor: AppColors.secondaryColor,
                            borderColor: AppColors.secondaryColor,
                            height: 31.15,
                            width: 127,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
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
