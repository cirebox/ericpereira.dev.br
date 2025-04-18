import '../../domain/entities/project.entity.dart';

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required Map<String, ProjectTranslation> translations,
    String imageUrl = '',
    String launch = '',
    ProjectType type = ProjectType.app,
    bool visible = true,
    String? urlDemo,
    List<String>? stack,
    String? githubUrl,
  }) : super(
          translations: translations,
          imageUrl: imageUrl,
          launch: launch,
          type: type,
          visible: visible,
          urlDemo: urlDemo,
          stack: stack,
          githubUrl: githubUrl,
        );

  ProjectModel.fromJson(Map<String, dynamic> json)
      : super(
          translations: _parseTranslations(json),
          imageUrl: json['imageUrl'] ?? '',
          launch: json['launch'] ?? '',
          type: _parseProjectType(json['type']),
          visible: json['visible'] ?? true,
          urlDemo: json['urlDemo'],
          stack: _parseStack(json['stack']),
          githubUrl: json['githubUrl'],
        );

  static Map<String, ProjectTranslation> _parseTranslations(
      Map<String, dynamic> json) {
    // Formato novo com campos de traduções
    if (json.containsKey('translations')) {
      final Map<String, dynamic> translationsJson = json['translations'] ?? {};
      final Map<String, ProjectTranslation> translations = {};

      translationsJson.forEach((lang, value) {
        translations[lang] = ProjectTranslation(
          name: value['name'] ?? '',
          description: value['description'],
          client: value['client'],
        );
      });

      return translations;
    }

    // Formato antigo: só possui campos simples, criar uma tradução padrão em português
    final ptTranslation = ProjectTranslation(
      name: json['name'] ?? '',
      description: json['description'],
      client: json['client'],
    );

    return {'pt': ptTranslation};
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

  static List<String>? _parseStack(dynamic stack) {
    if (stack == null) return null;

    if (stack is List) {
      return stack.map((item) => item.toString()).toList();
    }

    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> translationsJson = {};

    translations.forEach((lang, translation) {
      translationsJson[lang] = {
        'name': translation.name,
        'description': translation.description,
        'client': translation.client,
      };
    });

    return {
      'translations': translationsJson,
      'imageUrl': imageUrl,
      'urlDemo': urlDemo,
      'githubUrl': githubUrl,
      'type': type.toString().split('.').last,
      'visible': visible,
      'stack': stack,
      'launch': launch,
    };
  }
}
