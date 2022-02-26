import 'package:flutter/material.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 129,
        width: 129,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/images/main_logo.png'),
                fit: BoxFit.fill)));
  }
}
