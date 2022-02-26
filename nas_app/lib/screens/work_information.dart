import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nas_app/compnenets/medium_logo.dart';
import 'package:nas_app/compnenets/work_information_container.dart';
import 'package:nas_app/utils/app_colors.dart';

class WorkInformation extends StatefulWidget {
  const WorkInformation({Key? key}) : super(key: key);

  @override
  State<WorkInformation> createState() => _WorkInformationState();
}

class _WorkInformationState extends State<WorkInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 40, 15, 15),
          child: Column(
            children: [
              const MediumLogo(),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    verticalDirection: VerticalDirection.down,
                    children: [
                      WorkInformationContainer(
                        title: "معلومات العمل",
                        spaceTitle: 115,
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
