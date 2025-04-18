import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/domain/exceptions/exceptions.dart';
import '../../../shared/widgets/text_custom.dart';
import '../../../shared/i18n/app_translations.dart';
import '../../../shared/models/post_model.dart';
import '../store/news_store.dart';

class NewsLandingSection extends StatefulWidget {
  final List<PostModel> posts;

  const NewsLandingSection({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  State<NewsLandingSection> createState() => _NewsLandingSectionState();
}

class _NewsLandingSectionState extends State<NewsLandingSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black26
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Título da seção
          Align(
            alignment: Alignment.center,
            child: TextCustom(
              Translate.text('news', context),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // Subtítulo da seção
          Align(
            alignment: Alignment.center,
            child: TextCustom(
              'Confira as últimas atualizações e notícias',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withOpacity(0.7),
            ),
          ),

          const SizedBox(height: 40),

          // Lista de posts
          _buildPostsList(widget.posts),
        ],
      ),
    );
  }

  // Construir a lista de posts
  Widget _buildPostsList(List<PostModel> posts) {
    if (posts.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: TextCustom(
            'Nenhuma novidade disponível no momento.',
            fontSize: 16,
          ),
        ),
      );
    }

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Layout adaptativo baseado no tamanho da tela
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return _buildPostsMobileLayout(posts);
        } else {
          return _buildPostsDesktopLayout(posts);
        }
      },
    );
  }

  // Layout para dispositivos móveis - formato de lista
  Widget _buildPostsMobileLayout(List<PostModel> posts) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length > 3 ? 3 : posts.length, // Limita a 3 itens
      itemBuilder: (context, index) {
        final post = posts[index];
        return _buildPostCard(post, isCompact: true);
      },
    );
  }

  // Layout para desktop - formato de grid
  Widget _buildPostsDesktopLayout(List<PostModel> posts) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxItems = posts.length > 3 ? 3 : posts.length;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: List.generate(
            maxItems,
            (index) => SizedBox(
              width: constraints.maxWidth > 900
                  ? (constraints.maxWidth / 3) - 20
                  : (constraints.maxWidth / 2) - 20,
              child: _buildPostCard(posts[index]),
            ),
          ),
        );
      },
    );
  }

  // Card para exibir cada post
  Widget _buildPostCard(PostModel post, {bool isCompact = false}) {
    return InkWell(
      onTap: () {
        if (post.url != null) {
          if (post.url!.startsWith('/')) {
            // URL interna - navegar com Modular
            Modular.to.pushNamed(post.url!);
          } else {
            // URL externa - abrir no navegador
            _launchUrl(post.url!);
          }
        }
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: isCompact ? 16 : 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isCompact
              ? _buildCompactPostContent(post)
              : _buildExpandedPostContent(post),
        ),
      ),
    );
  }

  // Layout compacto para cards em dispositivos móveis
  Widget _buildCompactPostContent(PostModel post) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Data
        SizedBox(
          width: 80,
          child: TextCustom(
            post.date,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),

        // Conteúdo
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                post.title,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              if (post.detail != null) ...[
                const SizedBox(height: 5),
                TextCustom(
                  post.detail!,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textHeight: 1.3,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // Layout expandido para cards em desktop
  Widget _buildExpandedPostContent(PostModel post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Data
        TextCustom(
          post.date,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade700,
        ),

        const SizedBox(height: 10),

        // Título
        TextCustom(
          post.title,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),

        if (post.detail != null) ...[
          const SizedBox(height: 10),
          // Detalhes
          TextCustom(
            post.detail!,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textHeight: 1.3,
          ),
        ],

        const SizedBox(height: 15),

        // Botão "Saiba mais"
        if (post.url != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextCustom(
                'Saiba mais',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.arrow_forward,
                size: 14,
                color: Colors.blue,
              ),
            ],
          ),
      ],
    );
  }

  // Função para abrir URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
