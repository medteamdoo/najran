class AggrievedPlace {
  final int id;
  final String name;

  AggrievedPlace({required this.id, required this.name});

  factory AggrievedPlace.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      return value != null ? value.toString() : '';
    }

    return AggrievedPlace(id: json['id'] ?? 0, name: parseString(json['name']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
