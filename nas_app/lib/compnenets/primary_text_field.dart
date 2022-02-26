import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryTextField extends StatefulWidget {
  String hint;
  TextInputType inputType;
  TextInputAction inputAction;
  TextEditingController controller;
  bool obscure;
  double labelWidth;
  VoidCallback onChange;
  String textController;
  Color styleColor;
  double height;
  double sizeIcon;
  double fontSize;

  // ignore: use_key_in_widget_constructors
  PrimaryTextField(
      {required this.hint,
      required this.inputType,
      required this.inputAction,
      required this.controller,
      required this.obscure,
      required this.labelWidth,
      required this.onChange,
      required this.textController,
      required this.styleColor,
      required this.height,
      required this.sizeIcon,
      required this.fontSize,
      });

  @override
  _PrimaryTextFieldState createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextField(
        onChanged: (text){
          widget.onChange;
        },
        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText: widget.obscure,
        style: TextStyle(color: widget.styleColor),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.styleColor, width: 1.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.styleColor, width: 1.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          labelStyle:
              TextStyle(color: widget.styleColor, fontWeight: FontWeight.bold),
          contentPadding: const EdgeInsets.only(right: 30.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          label: SizedBox(
            width: widget.labelWidth,
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: widget.styleColor,
                  size: widget.sizeIcon,
                ),
                const SizedBox(width: 15),
                Text(
                  widget.hint,
                  style: TextStyle(fontSize: widget.fontSize),
                )
              ],
            ),
          ),
        ),
        autofocus: false,
      ),
    );
  }
}
