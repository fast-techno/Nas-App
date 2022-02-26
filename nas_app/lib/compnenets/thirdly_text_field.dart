import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nas_app/utils/app_colors.dart';

class ThirdlyTextField extends StatefulWidget {
  String hint;
  TextInputType inputType;
  TextInputAction inputAction;
  TextEditingController controller;
  double labelWidth;
  double contentPadding;
  Widget suffixIcon;
  Color borderColor;

  // ignore: use_key_in_widget_constructors
  ThirdlyTextField(
      {required this.hint,
        required this.inputType,
        required this.inputAction,
        required this.controller,
        required this.labelWidth,
      required this.contentPadding,
      required this.suffixIcon,
        required this.borderColor
      });

  @override
  _ThirdlyTextFieldState createState() => _ThirdlyTextFieldState();
}

class _ThirdlyTextFieldState extends State<ThirdlyTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 31.15,
      child: TextField(
        keyboardType: widget.inputType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(color:  widget.borderColor, width: 1.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: widget.borderColor, width: 1.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          labelStyle: TextStyle(
              color: AppColors.greyColor, fontSize: 14),
          contentPadding: EdgeInsets.only(right: widget.contentPadding),
          suffixIcon: widget.suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          labelText: widget.hint,
        ),
      ),
    );
  }
}
