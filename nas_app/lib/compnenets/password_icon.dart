import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class PasswordIcon extends StatelessWidget {
  PasswordIcon({Key? key, required this.obscureText}) : super(key: key);

  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return obscureText
        ? Container(
            margin: const EdgeInsets.all(12),
            child: SvgPicture.asset("assets/images/eye-hide.svg",
                color: Colors.white, width: 5, height: 5))
        : Container(
            margin: const EdgeInsets.all(12),
            child: SvgPicture.asset("assets/images/eye.svg",
                color: Colors.white, width: 5, height: 5));
  }
}
