class DepartmentModel {
  final int id;
  final String name;

  DepartmentModel({required this.id, required this.name});

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      return value != null ? value.toString() : '';
    }

    return DepartmentModel(
      id: json['id'] ?? 0,
      name: parseString(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
