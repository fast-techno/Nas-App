class JobModel {
  int? id;
  String? name;
  String? options;
  int? hasCheck;
  bool? active;

  JobModel({this.id, this.name, this.options, this.hasCheck, this.active});

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    options = json['options'];
  }

  @override
  String toString() {
    return 'JobModel{id: $id, name: $name, options: $options, hasCheck: $hasCheck}';
  }
}
