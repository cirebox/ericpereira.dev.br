class NewsModel {
  final String id;
  final String date;
  final String title;
  final String description;
  final String? url;
  final bool active;
  final String body;

  const NewsModel({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    this.url,
    required this.active,
    required this.body,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'],
      active: json['active'] ?? true,
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'description': description,
      'url': url,
      'active': active,
      'body': body,
    };
  }
}