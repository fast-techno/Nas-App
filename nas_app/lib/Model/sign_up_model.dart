class SignUp {
  String? phone;
  String? password;
  String? firstName;
  String? fatherName;
  String? grandfatherName;
  String? lastName;
  String? yearOfBirth;
  String? monthOfBirth;
  String? dayOfBirth;
  String? nationalNumber;
  String? gender;
  String? nationality;
  String? nationalityOther;
  String? maritalStatus;
  String? governorate;
  String? area;
  String? toldId;
  String? toldValue;
  String? jobId;
  String? preferredWorkingDays;
  String? preferredWorkingTimes;
  String? preferredWorkPeriod;
  String? receiveDues;
  String? workOnOccasions;
  String? needForTransportation;
  String? firstRelative;
  String? firstRelationship;
  String? firstRelativePhone;
  String? secondRelative;
  String? secondRelationship;
  String? secondRelativePhone;
  String? interviewId;

  SignUp(
      {this.phone,
      this.password,
      this.firstName,
      this.fatherName,
      this.grandfatherName,
      this.lastName,
      this.yearOfBirth,
      this.monthOfBirth,
      this.dayOfBirth,
      this.nationalNumber,
      this.gender,
      this.nationality,
      this.nationalityOther,
      this.maritalStatus,
      this.governorate,
      this.area,
      this.toldId,
      this.toldValue,
      this.jobId,
      this.preferredWorkingDays,
      this.preferredWorkingTimes,
      this.preferredWorkPeriod,
      this.receiveDues,
      this.workOnOccasions,
      this.needForTransportation,
      this.firstRelative,
      this.firstRelationship,
      this.firstRelativePhone,
      this.secondRelative,
      this.secondRelationship,
      this.secondRelativePhone,
      this.interviewId});

  SignUp.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    firstName = json['first_name'];
    fatherName = json['father_name'];
    grandfatherName = json['grandfather_name'];
    lastName = json['last_name'];
    yearOfBirth = json['year_of_birth'];
    monthOfBirth = json['month_of_birth'];
    dayOfBirth = json['day_of_birth'];
    nationalNumber = json['national_number'];
    gender = json['gender'];
    nationality = json['nationality'];
    nationalityOther = json['nationality_other'];
    maritalStatus = json['marital_status'];
    governorate = json['governorate'];
    area = json['area'];
    toldId = json['told_id'];
    toldValue = json['told_value'];
    jobId = json['job_id'];
    preferredWorkingDays = json['preferred_working_days'];
    preferredWorkingTimes = json['preferred_working_times'];
    preferredWorkPeriod = json['preferred_work_period'];
    receiveDues = json['receive_dues'];
    workOnOccasions = json['work_on_occasions'];
    needForTransportation = json['need_for_transportation'];
    firstRelative = json['first_relative'];
    firstRelationship = json['first_relationship'];
    firstRelativePhone = json['first_relative_phone'];
    secondRelative = json['second_relative'];
    secondRelationship = json['second_relationship'];
    secondRelativePhone = json['second_relative_phone'];
    interviewId = json['interview_id'];
  }
}
