enum ProjectType {
  app,
  website,
  websystem,
  apirest,
  software,
  other,
}

class ProjectEntity {
  final String id;
  final Map<String, String> nameByLang;
  final Map<String, String>? descriptionByLang;
  final Map<String, String>? clientByLang;
  final String? image;
  final String? url;
  final int? year;
  final List<String> technologies;
  final ProjectType type;
  final bool isHighlighted;

  ProjectEntity({
    required this.id,
    required this.nameByLang,
    this.descriptionByLang,
    this.clientByLang,
    this.image,
    this.url,
    this.year,
    this.technologies = const [],
    required this.type,
    this.isHighlighted = false,
  });

  // Getters para acesso aos campos traduzidos
  String getNameByLang(String langCode) {
    return nameByLang[langCode] ?? nameByLang['en'] ?? nameByLang.values.first;
  }

  String? getDescriptionByLang(String langCode) {
    if (descriptionByLang == null) return null;
    return descriptionByLang![langCode] ??
        descriptionByLang!['en'] ??
        descriptionByLang!.values.first;
  }

  String? getClientByLang(String langCode) {
    if (clientByLang == null) return null;
    return clientByLang![langCode] ??
        clientByLang!['en'] ??
        clientByLang!.values.first;
  }
}
