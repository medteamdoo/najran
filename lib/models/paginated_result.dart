class PaginatedResponse<T> {
  final int count;
  final int current;
  final int? next;
  final int? prev;
  final int totalPages;
  final List<T> results;

  PaginatedResponse({
    required this.count,
    required this.current,
    this.next,
    this.prev,
    required this.totalPages,
    required this.results,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final resultJsonList = json['result'] as List;
    final items = resultJsonList.map((e) => fromJsonT(e)).toList();

    return PaginatedResponse<T>(
      count: json['count'],
      current: json['current'],
      next: json['next'],
      prev: json['prev'],
      totalPages: json['total_pages'],
      results: items,
    );
  }
}
