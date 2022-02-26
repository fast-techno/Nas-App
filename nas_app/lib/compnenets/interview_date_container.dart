import 'package:flutter/material.dart';
import 'package:nas_app/Model/appointment_model.dart';
import 'package:nas_app/utils/app_colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';

class InterViewDateContainer extends StatelessWidget {
  InterViewDateContainer(
      {Key? key, required this.appointment, required this.padding})
      : super(key: key);

  double padding;
  Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 13.4,
          width: 13.4,
          decoration: BoxDecoration(
            color: appointment.isSelected
                ? AppColors.secondaryColor
                : AppColors.primaryColor,
            border: Border.all(width: 1.0, color: AppColors.secondaryColor),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(
          width: 235,
          child: Padding(
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
                              Html(
                                data: appointment.location!,
                                style: {
                                  '*': Style(
                                      color: AppColors.greyColor,
                                      fontSize: const FontSize(14)),
                                  'a': Style(
                                      color: Colors.blue,
                                      fontSize: const FontSize(14))
                                },
                                onLinkTap: (url, context, map, element) async {
                                  await launch(url.toString());
                                },
                              ),
                            ],
                          )
                        : Text("لا يوجد لديك مواعيد حاليا",
                            style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
