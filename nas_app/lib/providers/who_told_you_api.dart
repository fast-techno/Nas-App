import 'package:nas_app/providers/api_base_helper.dart';

class WhoToldYouApi {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future getSocialMedia(String token) async {
    try {
      final response = await _helper.get("whoToldYouOption/1",
          headers: {});
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future getOperatingDesk(String token) async {
    try {
      final response = await _helper.get("whoToldYouOption/3",
          headers: {});
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future getWelcomeMessage() async {
    try {
      final response = await _helper.get("welcomeMessage",
          headers: {});
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
