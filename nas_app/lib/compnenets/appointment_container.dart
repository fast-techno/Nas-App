import 'package:flutter/material.dart';
import 'package:nas_app/Model/appointment_model.dart';
import 'package:nas_app/utils/app_colors.dart';

class AppointmentContainer extends StatelessWidget {
  AppointmentContainer(
      {Key? key, required this.appointment, required this.padding})
      : super(key: key);

  double padding;
  Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: AppColors.greyColor)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Center(
              child: appointment.date != null
                  ? Column(
                      children: [
                        Text("${appointment.date} / ${appointment.time}",
                            style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text(appointment.location!,
                            style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  : Text("لا يوجد لديك مواعيد حاليا",
                      style: TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
            ),
          ),
        ));
  }
}
