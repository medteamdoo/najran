class CompensationReason {
  final int id;
  final String name;

  CompensationReason({required this.id, required this.name});

  factory CompensationReason.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      return value != null ? value.toString() : '';
    }

    return CompensationReason(
      id: json['id'] ?? 0,
      name: parseString(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
