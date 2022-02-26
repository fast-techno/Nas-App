import 'package:flutter/material.dart';

class SmallLogo extends StatelessWidget {
  const SmallLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      width: 33,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(
                  'assets/images/notification.png'))),
    );
  }
}
