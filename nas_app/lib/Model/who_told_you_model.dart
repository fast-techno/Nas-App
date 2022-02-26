import 'package:nas_app/Model/radio_button_model.dart';

class WhoToldYou {
  int? id;
  String? name;
  String? options;
  List<RadioButtonModel> option = [];

  WhoToldYou({this.id, this.name, this.options});

  WhoToldYou.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    options = json['options'];
  }
}
