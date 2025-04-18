import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/i18n/app_translations.dart';
import '../../../shared/models/post_model.dart';
import '../../../shared/services/news_service.dart';
import '../../../shared/widgets/text_custom.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({Key? key}) : super(key: key);

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  List<PostModel> _news = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    final newsService = Modular.get<INewsService>();
    final result = await newsService.getNews();

    setState(() {
      result.fold(
        (failure) {
          _errorMessage = failure.errorMessage;
          _isLoading = false;
        },
        (news) {
          _news = news;
          _isLoading = false;
        },
      );
    });
  }

  Future<void> _launchUrl(String url) async {
    if (url.startsWith('/')) {
      // Navegação interna (rota)
      Modular.to.navigate(url);
    } else {
      // URL externa
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Não foi possível abrir $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 40, right: 20, left: 0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black12
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título da seção
            TextCustom(
              Translate.text('news', context),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 10),

            // Subtítulo
            TextCustom(
              Translate.text('latestNews', context),
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withOpacity(0.7),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Conteúdo principal
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_errorMessage != null)
              TextCustom(
                _errorMessage!,
                fontSize: 16,
                color: Colors.red,
              )
            else if (_news.isEmpty)
              TextCustom(
                Translate.text('noNewsAvailable', context),
                fontSize: 16,
              )
            else
              // Lista de notícias no estilo blog (similar ao henriquetavares.com)
              Column(
                children: _news.map((news) => _buildNewsCard(news)).toList(),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildNewsCard(PostModel news) {
    // Calcular tempo de leitura aproximado (baseado no tamanho do conteúdo)
    final int readTime = _calculateReadTime(news.detail ?? '');

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: news.url != null && news.url!.isNotEmpty
            ? () => _launchUrl(news.url!)
            : null,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título no estilo de link (como no site henriquetavares.com)
            TextCustom(
              news.title,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),

            const SizedBox(height: 10),

            // Metadados: data e tempo de leitura (estilo henriquetavares.com)
            Row(
              children: [
                TextCustom(
                  news.date,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(0.7),
                ),

                const SizedBox(width: 10),

                // Ícone de xícara de café para indicar tempo de leitura
                Text(
                  '• ${_getReadTimeIcons(readTime)} $readTime min',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.7),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Descrição
            if (news.detail != null && news.detail!.isNotEmpty)
              TextCustom(
                news.detail!,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                textHeight: 1.5,
              ),

            const SizedBox(height: 20),

            // Divisor
            Divider(
              color: Theme.of(context).dividerColor.withOpacity(0.3),
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  // Calcula o tempo de leitura baseado no tamanho do texto
  int _calculateReadTime(String text) {
    // Média de palavras por minuto de leitura
    const wordsPerMinute = 200;

    // Estima o número de palavras no texto
    final wordCount = text.split(' ').length;

    // Calcula o tempo de leitura em minutos (mínimo 1 minuto)
    return (wordCount / wordsPerMinute).ceil().clamp(1, 30);
  }

  // Retorna ícones de xícara de café baseado no tempo de leitura
  // Semelhante ao usado no site henriquetavares.com
  String _getReadTimeIcons(int minutes) {
    if (minutes <= 3) {
      return '☕️';
    } else if (minutes <= 7) {
      return '☕️☕️';
    } else {
      return '☕️☕️☕️';
    }
  }
}
