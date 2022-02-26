import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  String title;
  Color fillColor;
  Color textColor;

  SecondaryButton({Key? key, required this.title, required this.fillColor, required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41.76,
      width: 136,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.88),
          border: Border.all(width: 1, color: Colors.white),
          color: fillColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Center(
          child: Text(
            title,
            style:  TextStyle(
                fontSize: 17, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
