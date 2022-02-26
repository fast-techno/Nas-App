import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nas_app/Model/radio_button_model.dart';
import 'package:nas_app/Model/who_told_you_model.dart';
import 'package:nas_app/providers/who_told_you_api.dart';

class WhoToldYouController extends GetxController {
  WhoToldYou socialMedia = WhoToldYou();
  WhoToldYou operatingDesk = WhoToldYou();
  String? welcomeMessage;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchSocialMediaOption();
    fetchOperatingDeskOption();
    fetchWelcomeMessage();
  }

  fetchSocialMediaOption() async {
    EasyLoading.show(status: "تحميل");
    await WhoToldYouApi().getSocialMedia("").then((value) {
      for (var element in value['data']) {
        String option = element['options'];
        option = option.replaceAll("[", "");
        option = option.replaceAll("]", "");
        option = option.replaceAll('"', "");
        List<String> temp = option.split(',');
        for (var element in temp) {
          RadioButtonModel radio =
              RadioButtonModel(name: element, active: false);
          socialMedia.option.add(radio);
        }
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }

  fetchOperatingDeskOption() async {
    EasyLoading.show(status: "تحميل");
    await WhoToldYouApi().getOperatingDesk("").then((value) {
      for (var element in value['data']) {
        String option = element['options'];
        option = option.replaceAll("[", "");
        option = option.replaceAll("]", "");
        option = option.replaceAll('"', "");
        List<String> temp = option.split(',');
        for (var element in temp) {
          RadioButtonModel radio =
          RadioButtonModel(name: element, active: false);
          operatingDesk.option.add(radio);
        }
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }

  fetchWelcomeMessage() async {
    EasyLoading.show(status: "تحميل");
    await WhoToldYouApi().getWelcomeMessage().then((value) {
      for (var element in value['data']) {
        welcomeMessage = element['content'];
      }
    }).catchError((e) => throw e);
    EasyLoading.dismiss();
    update();
  }
}
