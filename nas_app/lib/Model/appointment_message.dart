class AppointmentMessage {
  int? id;
  String? name;
  String? content;

  AppointmentMessage({this.id, this.name, this.content});

  AppointmentMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
  }
}
