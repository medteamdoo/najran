class RequestType {
  final int id;
  final String name;

  RequestType({required this.id, required this.name});

  factory RequestType.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      return value != null ? value.toString() : '';
    }

    return RequestType(id: json['id'] ?? 0, name: parseString(json['name']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
