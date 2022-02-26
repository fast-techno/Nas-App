import 'package:flutter/material.dart';
import 'package:nas_app/utils/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  String title;
  Color textColor;
  double textSize;
  Color borderColor;
  Color fillColor;
  double height;
  double width;

  PrimaryButton(
      {Key? key,
      required this.title,
      required this.textColor,
      required this.textSize,
      required this.fillColor,
      required this.borderColor,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.57),
          border: Border.all(width: 1, color: borderColor),
          color: fillColor),
      child: Center(
        child: Text(title,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.bold,
              color: textColor,
            )),
      ),
    );
  }
}
