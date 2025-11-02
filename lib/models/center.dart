class CenterModel {
  final int id;
  final String name;

  CenterModel({required this.id, required this.name});

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      return value != null ? value.toString() : '';
    }

    return CenterModel(id: json['id'] ?? 0, name: parseString(json['name']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
