import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nas_app/Model/appointment_message.dart';
import 'package:nas_app/Model/appointment_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nas_app/providers/appointment_api.dart';

class HomeController extends GetxController {
  Appointment appointment = Appointment();
  List<Appointment> previousAppointments = [];
  List<Appointment> appointments = [];
  List<AppointmentMessage> messages = [];
  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchAppointment();
    fetchAppointmentMessage();
    fetchAppointments();
  }

  fetchAppointment() async {
    appointment = Appointment();
    EasyLoading.show(status: "تحميل");
    await AppointmentApi().getAppointment(box.read('token')).then((value) {
      if (value['status']) {
        appointment.id = value['data']['id'];
        appointment.date = value['data']['date'];
        appointment.time = value['data']['time'];
        appointment.location = value['data']['location'];
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }

  fetchAppointments() async {
    appointments = [];
    previousAppointments = [];
    EasyLoading.show(status: "تحميل");
    await AppointmentApi().getAppointments(box.read('token')).then((value) {
      if (value['status']) {
        for (var element in value['data']) {
          Appointment appointment = Appointment();
          if (element['status'] == 'active') {
            appointment.id = element['id'];
            appointment.date = element['date'];
            appointment.time = element['time'];
            appointment.location = element['location'];
            appointments.add(appointment);
          } else {
            appointment.id = element['id'];
            appointment.date = element['date'];
            appointment.time = element['time'];
            appointment.location = element['location'];
            previousAppointments.add(appointment);
          }
        }
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }

  fetchAppointmentMessage() async {
  messages = [];
    EasyLoading.show(status: "تحميل");
    await AppointmentApi()
        .getAppointmentMessage(box.read('token'))
        .then((value) {
      if (value['status']) {
        for (var element in value['data']) {
          AppointmentMessage message = AppointmentMessage();
          message.id = element['id'];
          message.content = element['content'];
          messages.add(message);
        }
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }

  cancelledAppointment(int id) async {
    EasyLoading.show(status: "تحميل");
    await AppointmentApi()
        .cancelAppointment(id, box.read('token'))
        .then((value) {

    })
        .catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }
}
