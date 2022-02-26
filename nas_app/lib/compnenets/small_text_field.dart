import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallTextField extends StatefulWidget {
  String hint;
  TextInputType inputType;
  TextInputAction inputAction;
  TextEditingController controller;
  bool obscure;
  double labelWidth;

  // ignore: use_key_in_widget_constructors
  SmallTextField(
      {required this.hint,
      required this.inputType,
      required this.inputAction,
      required this.controller,
      required this.obscure,
      required this.labelWidth});

  @override
  _SmallTextFieldState createState() => _SmallTextFieldState();
}

class _SmallTextFieldState extends State<SmallTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 31.15,
      child: TextField(
        keyboardType: widget.inputType,
        obscureText: widget.obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          labelStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          contentPadding: const EdgeInsets.only(right: 30.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          label: SizedBox(
            width: widget.labelWidth,
            child: Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 12,
                ),
                const SizedBox(width: 12),
                Text(widget.hint)
              ],
            ),
          ),
        ),
        autofocus: false,
      ),
    );
  }
}
