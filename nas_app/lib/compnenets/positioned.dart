import 'package:flutter/material.dart';
import 'package:nas_app/utils/app_colors.dart';

// ignore: must_be_immutable
class PositionedOne extends StatelessWidget {
  PositionedOne({Key? key, required this.spaceTitle}) : super(key: key);

  double spaceTitle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 9,
      right: 55,
      child: Container(
        height: 9,
        width: spaceTitle,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}

// ignore: must_be_immutable
class PositionedTwo extends StatelessWidget {
  PositionedTwo({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -3,
      right: 70,
      child: Text(title, style: Theme.of(context).textTheme.bodyText1),
    );
  }
}

// ignore: must_be_immutable
class PositionedThree extends StatelessWidget {
  const PositionedThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      right: 45,
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
