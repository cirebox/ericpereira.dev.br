import 'package:flutter_triple/flutter_triple.dart';
import '../../../core/domain/exceptions/exceptions.dart';
import '../../../shared/models/post_model.dart';
import '../../../shared/services/news_service.dart';

class NewsLandingStore extends NotifierStore<Failure, List<PostModel>> {
  final INewsService _newsService;

  NewsLandingStore(this._newsService) : super([]);

  Future<void> loadNews() async {
    setLoading(true);

    try {
      final result = await _newsService.getNews();

      result.fold(
        (failure) => setError(failure),
        (news) {
          // Converter NewsModel para PostModel
          final posts = news
              .map((news) => PostModel(
                    date: news.date,
                    title: news.title,
                    detail: news.detail,
                    url: news.url,
                    translations: {},
                  ))
              .toList();
          update(posts);
        },
      );
    } catch (e) {
      setError(FailureRequest(
        errorMessage: 'Erro inesperado ao carregar novidades',
        exception: e,
      ));
    } finally {
      setLoading(false);
    }
  }
}
