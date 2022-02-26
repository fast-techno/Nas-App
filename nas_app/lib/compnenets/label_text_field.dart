import 'package:flutter/material.dart';
import 'package:nas_app/utils/app_colors.dart';

// ignore: must_be_immutable
class LabelTextField extends StatelessWidget {
  LabelTextField({
    Key? key,
    required this.text,
    required this.spaceText,
    required this.fontSize,
    required this.sizeIcon,
  }) : super(key: key);

  double spaceText;
  String text;
  double fontSize;
  double sizeIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: spaceText,
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: AppColors.secondaryColor,
            size: sizeIcon,
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(fontSize: fontSize),
          )
        ],
      ),
    );
  }
}
