class PostTranslation {
  final String title;
  final String? detail;
  final String? body;

  const PostTranslation({
    required this.title,
    this.detail,
    this.body,
  });

  factory PostTranslation.fromJson(Map<String, dynamic> json) {
    return PostTranslation(
      title: json['title'] ?? '',
      detail: json['detail'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'detail': detail,
      'body': body,
    };
  }
}

class PostModel {
  final String date;
  final Map<String, PostTranslation> translations;
  final String? url;
  final bool active;

  const PostModel({
    required this.date,
    required this.translations,
    this.url,
    this.active = true,
  });

  // Getters para facilitar o acesso aos campos do idioma atual ou padrão
  String get title => _getTranslation('pt').title;
  String? get detail => _getTranslation('pt').detail;
  String? get body => _getTranslation('pt').body;

  // Método para obter a tradução para um idioma específico ou fallback para português
  PostTranslation _getTranslation(String langCode) {
    return translations[langCode] ?? translations['pt']!;
  }

  // Método para obter o título traduzido para um idioma específico
  String getTitleByLang(String langCode) {
    return _getTranslation(langCode).title;
  }

  // Método para obter o detalhe traduzido para um idioma específico
  String? getDetailByLang(String langCode) {
    return _getTranslation(langCode).detail;
  }

  // Método para obter o corpo traduzido para um idioma específico
  String? getBodyByLang(String langCode) {
    return _getTranslation(langCode).body;
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // Se o formato antigo não tiver 'translations', cria uma estrutura compatível
    if (!json.containsKey('translations')) {
      final ptTranslation = PostTranslation(
        title: json['title'] ?? '',
        detail: json['detail'],
        body: json['body'],
      );

      return PostModel(
        date: json['date'] ?? '',
        translations: {'pt': ptTranslation},
        url: json['url'],
        active: json['active'] ?? true,
      );
    }

    // Formato novo com traduções
    final Map<String, dynamic> translationsJson = json['translations'] ?? {};
    final Map<String, PostTranslation> translations = {};

    translationsJson.forEach((lang, value) {
      translations[lang] = PostTranslation.fromJson(value);
    });

    return PostModel(
      date: json['date'] ?? '',
      translations: translations,
      url: json['url'],
      active: json['active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> translationsJson = {};

    translations.forEach((lang, translation) {
      translationsJson[lang] = translation.toJson();
    });

    return {
      'date': date,
      'translations': translationsJson,
      'url': url,
      'active': active,
    };
  }
}
