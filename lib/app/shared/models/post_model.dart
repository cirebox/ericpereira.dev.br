class PostModel {
  final String date;
  final String title;
  final String? detail;
  final String? url;

  const PostModel({
    required this.date,
    required this.title,
    this.detail,
    this.url,
  });
}
