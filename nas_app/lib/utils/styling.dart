import 'package:nas_app/utils/app_colors.dart';
import 'package:flutter/material.dart';


class Styling {
  // TextField
  static TextStyle labelTextField =
  TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.bold);
  static OutlineInputBorder focusedBorderTextField = OutlineInputBorder(
    borderSide: BorderSide(
        color: AppColors.secondaryColor, width: 1.0),
    borderRadius: BorderRadius.circular(50.0),
  );
  static OutlineInputBorder enabledBorderTextField = OutlineInputBorder(
    borderSide: BorderSide(
        color: AppColors.secondaryColor, width: 1.0),
    borderRadius: BorderRadius.circular(50.0),
  );


  // Card
  static RoundedRectangleBorder roundedRectangleBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: BorderSide(
      color: AppColors.secondaryColor,
      width: 1.0,
    ),
  );
}
