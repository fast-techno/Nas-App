import 'package:nas_app/Model/login_model.dart';
import 'package:nas_app/providers/api_base_helper.dart';

class LoginApi {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future login(Login obj) async {
    try {
      final response = await _helper.post("login", {
        "phone": obj.phone.toString(),
        "password": obj.password.toString(),
      });
      return response;
    } catch (ex) {
      rethrow;
    }
  }

}
