class BelongingModel {
  final int id;
  final String name;

  BelongingModel({required this.id, required this.name});

  factory BelongingModel.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      return value != null ? value.toString() : '';
    }

    return BelongingModel(id: json['id'] ?? 0, name: parseString(json['name']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
