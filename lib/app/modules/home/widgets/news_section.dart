import 'package:flutter/material.dart';

import '../../../shared/models/post_model.dart';
import '../../../shared/widgets/posts_widgets.dart';
import '../../../shared/widgets/text_custom.dart';

class NewsSection extends StatelessWidget {
  final List<PostModel> posts;
  final String title;
  final double titleFontSize;

  const NewsSection({
    Key? key,
    required this.posts,
    this.title = 'Novidades',
    this.titleFontSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Se não houver posts, não exibir a seção
    if (posts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: TextCustom(
            title,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            height: 0.2,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: posts
                .map((post) => PostWidget(
                      date: post.date,
                      title: post.title,
                      detail: post.detail,
                      url: post.url,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
