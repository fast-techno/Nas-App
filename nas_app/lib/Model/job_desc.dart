class JobDesc {
  int? id;
  String? name;
  String? options;


  JobDesc({this.id, this.name, this.options});

  JobDesc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    options = json['options'];
  }
}
