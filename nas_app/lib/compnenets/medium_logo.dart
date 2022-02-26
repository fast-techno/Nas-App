import 'package:flutter/material.dart';

class MediumLogo extends StatelessWidget {
  const MediumLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Center(
        child: Container(
          height: 62.92,
          width: 63.78,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(
                      'assets/images/main_logo.png'))),
        ),
      ),
    );
  }
}
