import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nas_app/Model/check_box_model.dart';
import 'package:nas_app/Model/job_desc.dart';
import 'package:nas_app/Model/job_model.dart';
import 'package:nas_app/Model/radio_button_model.dart';
import 'package:nas_app/providers/job_option_api.dart';

class JobController extends GetxController {
  List<JobModel> jobs = [];
  List<CheckBoxModel> workDay = [];
  List<CheckBoxModel> workTime = [];
  List<CheckBoxModel> workTime2 = [];
  List<RadioButtonModel> holiday = [];
  List<RadioButtonModel> travel = [];
  List<CheckBoxModel> moneyReceive = [];
  JobDesc jobDesc = JobDesc();
  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchJobTypeOption();
    initState();
  }

  void selectJobType(int index){
    jobs[index].active =  jobs[index].active;
    update();
  }

  fetchJobTypeOption() async {
    EasyLoading.show(status: "تحميل");
    await JobOptionApi().getJobOption("").then((value) {
      for (var element in value['data']) {
        JobModel jobModel = JobModel();
        jobModel.id = element['id'];
        jobModel.name = element['name'];
        jobModel.active = false;
        if (element['options'] == "[null]") {
          jobModel.hasCheck = 0;
        } else {
          jobModel.hasCheck = 1;
        }
        jobs.add(jobModel);
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }

  fetchJobDesc(int id) async {
    jobDesc = JobDesc();
    EasyLoading.show(status: "تحميل");
    await JobOptionApi()
        .getJobDesc(id)
        .then((value) {
      if (value['status']) {
        for (var element in value['data']) {
          jobDesc.id = element['id'];
          jobDesc.name = element['name'];
          jobDesc.options = element['options'];
        }
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }

  initState() async {
    EasyLoading.show(status: "تحميل");
    workDay.add(CheckBoxModel('الأحد', false));
    workDay.add(CheckBoxModel('الإثنين', false));
    workDay.add(CheckBoxModel('الثلاثاء', false));
    workDay.add(CheckBoxModel('الأربعاء', false));
    workDay.add(CheckBoxModel('الخميس', false));
    workDay.add(CheckBoxModel('الجمعة', false));
    workDay.add(CheckBoxModel('السبت', false));
    workTime.add(CheckBoxModel('الصباح', false));
    workTime.add(CheckBoxModel('المساء', false));
    workTime.add(CheckBoxModel('الليل', false));
    holiday.add(RadioButtonModel(name: 'نعم', active: false));
    holiday.add(RadioButtonModel(name: 'لا', active: false));
    travel.add(RadioButtonModel(name: 'نعم', active: false));
    travel.add(RadioButtonModel(name: 'لا', active: false));
    workTime2.add(CheckBoxModel('يومي', false));
    workTime2.add(CheckBoxModel('أسبوعي', false));
    workTime2.add(CheckBoxModel('شهري', false));
    moneyReceive.add(CheckBoxModel('يومي', false));
    moneyReceive.add(CheckBoxModel('أسبوعي', false));
    moneyReceive.add(CheckBoxModel('شهري', false));
    EasyLoading.dismiss();
    update();
  }
}
