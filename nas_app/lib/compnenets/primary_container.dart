import 'package:flutter/material.dart';
import 'package:nas_app/utils/app_colors.dart';

class PrimaryContainer extends StatelessWidget {
  PrimaryContainer(
      {Key? key,
      required this.title,
      required this.spaceTitle,
      required this.containWidget})
      : super(key: key);
  String title;
  double spaceTitle;
  Widget containWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(20)),
        child: containWidget,
      ),
      Positioned(
        top: 15,
        right: 55,
        child: Container(
          height: 9,
          width: spaceTitle,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
      Positioned(
        top: 0,
        right: 75,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1),
      ),
      Positioned(
        top: 8,
        right: 50,
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
        ),
      ),
    ]);
  }
}
