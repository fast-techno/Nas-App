import 'package:nas_app/providers/api_base_helper.dart';

class InterviewDateApi {
  final ApiBaseHelper _helper = ApiBaseHelper();
  Future getAppointments() async {
    try {
      final response = await _helper
          .get("interviews/", headers: {});
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future getTermsAgree() async {
    try {
      final response = await _helper
          .get("termsAgree/", headers: {});
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
