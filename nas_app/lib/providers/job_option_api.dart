import 'package:nas_app/Model/job_desc.dart';
import 'package:nas_app/providers/api_base_helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class JobOptionApi {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future getJobOption(String token) async {
    try {
      final response = await _helper.get("job",
          headers: {});
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future getJobDesc(int id) async {
    try {
      final response = await _helper.get("jobOption/$id",
          headers: {});
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
