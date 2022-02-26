import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nas_app/compnenets/change_date_dialog.dart';
import 'package:nas_app/compnenets/course_date_container.dart';
import 'package:nas_app/compnenets/personal_information_container.dart';
import 'package:nas_app/compnenets/primary_button.dart';
import 'package:nas_app/compnenets/primary_container.dart';
import 'package:nas_app/compnenets/relatives_information_container.dart';
import 'package:nas_app/compnenets/who_told_you_container.dart';
import 'package:nas_app/compnenets/work_information_container.dart';
import 'package:nas_app/screens/interview_date.dart';
import 'package:nas_app/screens/login_page.dart';
import 'package:nas_app/utils/app_colors.dart';

class RelativesInformation extends StatefulWidget {
  const RelativesInformation({Key? key}) : super(key: key);

  @override
  State<RelativesInformation> createState() => _RelativesInformationState();
}

class _RelativesInformationState extends State<RelativesInformation> {
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
                    height: 62.92,
                    width: 63.78,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage(
                                'assets/images/main_logo.png'))),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    verticalDirection: VerticalDirection.down,
                    children: [
                      RelativesInformationContainer(
                        title: "معلومات الأقارب",
                        spaceTitle: 140,
                        heightContainer: 0,
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
