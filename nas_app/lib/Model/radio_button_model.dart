class RadioButtonModel {
  final String name;
  late bool active;

  RadioButtonModel({required this.name, required this.active});

  @override
  String toString() {
    return 'RadioButtonModel{name: $name, active: $active}';
  }
}
