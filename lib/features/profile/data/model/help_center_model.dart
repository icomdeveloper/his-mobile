class Policy {
  final int id;
  final String title;
  final String body;
  final Category category;

  Policy({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
  });

  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      category: Category.fromJson(json['category'] ?? {}),
    );
  }
}

class Category {
  final int id;
  final String title;

  Category({
    required this.id,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
    );
  }
}
