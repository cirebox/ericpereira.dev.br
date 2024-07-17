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
  ProjectType type;
  bool visible;
  List<String>? stack;
  String launch;
  ProjectEntity({
    required this.name,
    required this.imageUrl,
    required this.launch,
    required this.type,
    this.visible = false,
    this.urlDemo,
    this.stack,
  });
}
