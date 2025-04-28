import '../../domain/entities/project.entity.dart';
import 'project_translation.dart';

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required String id,
    required Map<String, String> nameByLang,
    Map<String, String>? descriptionByLang,
    Map<String, String>? clientByLang,
    String? imageUrl,
    String? urlDemo,
    int? year,
    List<String> technologies = const [],
    required ProjectType type,
    bool isHighlighted = false,
  }) : super(
          id: id,
          nameByLang: nameByLang,
          descriptionByLang: descriptionByLang,
          clientByLang: clientByLang,
          image: imageUrl,
          url: urlDemo,
          year: year,
          technologies: technologies,
          type: type,
          isHighlighted: isHighlighted,
        );

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    Map<String, String> nameByLang = {};
    Map<String, String> descriptionByLang = {};
    Map<String, String> clientByLang = {};
    List<String> technologies = [];

    // Processar as traduções
    if (json.containsKey('translations')) {
      final Map<String, dynamic> translationsJson = json['translations'] ?? {};

      translationsJson.forEach((lang, value) {
        if (value['name'] != null) nameByLang[lang] = value['name'];
        if (value['description'] != null)
          descriptionByLang[lang] = value['description'];
        if (value['client'] != null) clientByLang[lang] = value['client'];
      });
    } else {
      // Formato antigo sem traduções
      if (json['name'] != null) nameByLang['pt'] = json['name'];
      if (json['description'] != null)
        descriptionByLang['pt'] = json['description'];
      if (json['client'] != null) clientByLang['pt'] = json['client'];
    }

    // Processar a stack/technologies
    if (json['stack'] != null && json['stack'] is List) {
      technologies =
          List<String>.from(json['stack'].map((item) => item.toString()));
    }

    return ProjectModel(
      id: json['id'] ?? '',
      nameByLang: nameByLang,
      descriptionByLang:
          descriptionByLang.isNotEmpty ? descriptionByLang : null,
      clientByLang: clientByLang.isNotEmpty ? clientByLang : null,
      imageUrl: json['imageUrl'],
      urlDemo: json['urlDemo'],
      year: json['launch'] != null
          ? int.tryParse(json['launch'].toString())
          : null,
      technologies: technologies,
      type: _parseProjectType(json['type']),
      isHighlighted: json['visible'] ?? false,
    );
  }

  static ProjectType _parseProjectType(dynamic type) {
    if (type == null) return ProjectType.other;

    try {
      if (type is ProjectType) return type;
      if (type is String) {
        switch (type.toLowerCase()) {
          case 'app':
            return ProjectType.app;
          case 'website':
            return ProjectType.website;
          case 'websystem':
            return ProjectType.websystem;
          case 'apirest':
            return ProjectType.apirest;
          case 'software':
            return ProjectType.software;
          default:
            return ProjectType.other;
        }
      }
    } catch (e) {
      // Em caso de erro, retorna o tipo "other"
    }

    return ProjectType.other;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> translationsJson = {};

    nameByLang.forEach((lang, name) {
      translationsJson[lang] = {'name': name};

      if (descriptionByLang != null && descriptionByLang!.containsKey(lang)) {
        translationsJson[lang]['description'] = descriptionByLang![lang];
      }

      if (clientByLang != null && clientByLang!.containsKey(lang)) {
        translationsJson[lang]['client'] = clientByLang![lang];
      }
    });

    return {
      'id': id,
      'translations': translationsJson,
      'imageUrl': image,
      'urlDemo': url,
      'launch': year?.toString(),
      'type': type.toString().split('.').last,
      'visible': isHighlighted,
      'stack': technologies,
    };
  }
}
