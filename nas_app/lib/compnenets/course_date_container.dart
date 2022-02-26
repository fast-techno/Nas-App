import 'package:flutter/material.dart';
import 'package:nas_app/utils/app_colors.dart';

class CourseDateContainer extends StatelessWidget {
  CourseDateContainer({Key? key, required this.padding}) : super(key: key);

  double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding, top: padding),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2, color: AppColors.greyColor)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Center(
              child: Column(
            children: [
              Text("الثلاثاء / 01-01-2022 3:00 ص",
                  style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              Text("الشيمساني",
                  style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ],
          )),
        ),
      ),
    );
  }
}
