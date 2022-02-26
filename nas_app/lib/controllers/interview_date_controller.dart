import 'package:get/get.dart';
import 'package:nas_app/Model/appointment_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nas_app/providers/intreview_date_api.dart';

class InterviewDateController extends GetxController {
  List<Appointment> appointments = [];
  List<Appointment> changeAppointments = [];
  String termsAgree = "";

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
    fetchTermsAgree();
  }

  fetchAppointments() async {
    EasyLoading.show(status: "تحميل");
    await InterviewDateApi().getAppointments().then((value) {
      for (var element in value['data']) {
        Appointment appointment = Appointment();
        appointment.id = element['id'];
        appointment.date = element['date'];
        appointment.time = element['time'];
        appointment.location = element['location'];
        appointments.add(appointment);
        changeAppointments.add(appointment);
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }

  fetchTermsAgree() async {
    EasyLoading.show(status: "تحميل");
    await InterviewDateApi().getTermsAgree().then((value) {
      if(value['data'] != null){
        for (var element in value['data']) {
          termsAgree = "$termsAgree${element['content']}";
        }
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }
}
