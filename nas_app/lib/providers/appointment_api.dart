import 'package:nas_app/providers/api_base_helper.dart';

class AppointmentApi {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future getAppointment(String token) async {
    try {
      final response = await _helper
          .get("appointment/", headers: {"Authorization": "Bearer " + token});
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future getAppointments(String token) async {
    try {
      final response = await _helper
          .get("appointments/", headers: {"Authorization": "Bearer " + token});
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future getAppointmentMessage(String token) async {
    try {
      final response = await _helper.get("appointmentMessage/",
          headers: {"Authorization": "Bearer " + token});
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future cancelAppointment(int id, String token) async {
    try {
      final response = await _helper.put("cancelled/$id", {},
          headers: {"Authorization": "Bearer " + token});
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
