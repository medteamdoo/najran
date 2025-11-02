class RelativeModel {
  final int id;
  final String name;

  RelativeModel({required this.id, required this.name});

  factory RelativeModel.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      return value != null ? value.toString() : '';
    }

    return RelativeModel(id: json['id'] ?? 0, name: parseString(json['name']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
