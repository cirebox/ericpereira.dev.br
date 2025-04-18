enum ProjectType {
  app,
  website,
  websystem,
  apirest,
  software,
  other,
}

class ProjectEntity {
  String name;
  String imageUrl;
  String? urlDemo;
  String? githubUrl;
  ProjectType type;
  bool visible;
  List<String>? stack;
  String launch;
  String? description;
  String? client;

  ProjectEntity({
    required this.name,
    required this.imageUrl,
    required this.launch,
    required this.type,
    this.visible = true,
    this.urlDemo,
    this.stack,
    this.description,
    this.client,
    this.githubUrl,
  });
}
