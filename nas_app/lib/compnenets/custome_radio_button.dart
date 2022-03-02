import 'package:flutter/material.dart';
import 'package:nas_app/Model/appointment_model.dart';
import 'package:nas_app/utils/app_colors.dart';

class CustomRadioItem extends StatelessWidget {
  final Appointment _appointment;

  // ignore: prefer_const_constructors_in_immutables
  CustomRadioItem(this._appointment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 15.4,
            width: 15.4,
            decoration: BoxDecoration(
              color: _appointment.isSelected ? Colors.black : Colors.white,
              border: Border.all(width: 2.0, color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Container(
            width: 190,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: AppColors.primaryColor)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                  child: Column(
                children: [
                  Text(
                    "${_appointment.date!}  / ${_appointment.time!}",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(_appointment.location!,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
