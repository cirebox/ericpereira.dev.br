import '../../domain/entities/project.entity.dart';

class ProjectModel extends ProjectEntity {
  ProjectModel({
    String name = '',
    String imageUrl = '',
    String launch = '',
    ProjectType type = ProjectType.app,
    bool visible = true,
    String? urlDemo,
    List<String>? stack,
  }) : super(
          name: name,
          imageUrl: imageUrl,
          launch: launch,
          type: type,
          visible: visible,
          urlDemo: urlDemo,
          stack: stack,
        );

  ProjectModel.fromJson(Map<String, dynamic> json)
      : super(
          name: json['name'],
          imageUrl: json['imageUrl'],
          launch: json['launch'],
          type: json['type'],
          visible: json['visible'],
          urlDemo: json['urlDemo'],
          stack: json['stack'],
        ) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    launch = json['launch'];
    type = json['type'];
    visible = json['visible'];
    urlDemo = json['urlDemo'];
    stack = json['stack'];
  }
}
