import 'package:nas_app/providers/api_base_helper.dart';

class ForgotPasswordApi {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future forgotPassword(String phoneNo) async {
    try {
      final response = await _helper.post("forgot_password?phone=$phoneNo", {});
      return response;
    } catch (ex) {
      rethrow;
    }
  }


  Future changePassword(String phoneNo, String newPassword,String confirmPassword) async {
    try {
      final response = await _helper.post("change_password?phone=$phoneNo&new_password=$newPassword&confirm_password=$confirmPassword", {});
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
