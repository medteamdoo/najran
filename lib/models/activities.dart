class Activities {
  final String name;
  final int totalActivities;
  final int messages;

  Activities({
    required this.name,
    required this.totalActivities,
    required this.messages,
  });

  factory Activities.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      return value != null ? value.toString() : '';
    }

    return Activities(
      name: parseString(json['name_ar']),
      totalActivities: json['total'] ?? 0,
      messages: json['waiting_for_response'] ?? 0,
    );
  }
}
