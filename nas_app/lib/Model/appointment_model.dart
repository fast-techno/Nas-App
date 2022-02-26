class Appointment {
  int? id;
  String? date;
  String? time;
  String? location;
  String? status;
  bool isSelected = false;

  Appointment({this.id, this.date, this.time, this.location, this.status});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    location = json['location'];
    status = json['status'];
  }
}
