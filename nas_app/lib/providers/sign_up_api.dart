import 'package:nas_app/Model/login_model.dart';
import 'package:nas_app/Model/sign_up_model.dart';
import 'package:nas_app/providers/api_base_helper.dart';

class SignUpApi {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future signUp(SignUp obj) async {
    try {
      final response = await _helper.post("signup", {
        "phone": obj.phone.toString(),
        "password": obj.password.toString(),
        "first_name": obj.firstName.toString(),
        "father_name": obj.fatherName.toString(),
        "grandfather_name": obj.grandfatherName.toString(),
        "last_name": obj.lastName.toString(),
        "year_of_birth": obj.yearOfBirth.toString(),
        "month_of_birth": obj.monthOfBirth.toString(),
        "day_of_birth": obj.dayOfBirth.toString(),
        "national_number": obj.nationalNumber.toString(),
        "gender": obj.gender.toString(),
        "nationality": obj.nationality.toString(),
        "nationality_other": obj.nationalityOther.toString(),
        "marital_status": obj.maritalStatus.toString(),
        "governorate": obj.governorate.toString(),
        "area": obj.area.toString(),
        "told_id": obj.toldId.toString(),
        "told_value": obj.toldValue.toString(),
        "job_id": obj.jobId.toString(),
        "preferred_working_days": obj.preferredWorkingDays.toString(),
        "preferred_working_times": obj.preferredWorkingTimes.toString(),
        "preferred_work_period": obj.preferredWorkPeriod.toString(),
        "receive_dues": obj.receiveDues.toString(),
        "work_on_occasions": obj.workOnOccasions.toString(),
        "need_for_transportation": obj.needForTransportation.toString(),
        "first_relative": obj.firstRelative.toString(),
        "first_relationship": obj.firstRelationship.toString(),
        "first_relative_phone": obj.firstRelativePhone.toString(),
        "second_relative": obj.secondRelative.toString(),
        "second_relationship": obj.secondRelationship.toString(),
        "second_relative_phone": obj.secondRelativePhone.toString(),
        "interview_id": obj.interviewId.toString(),
      });
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future getRegisterConfirmation() async {
    try {
      final response = await _helper
          .get("registerConfirmation/", headers: {});
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
