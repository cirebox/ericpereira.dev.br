import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../core/domain/exceptions/exceptions.dart';
import '../models/post_model.dart';

abstract class INewsService {
  Future<Either<Failure, List<PostModel>>> getNews();
}

class NewsService implements INewsService {
  @override
  Future<Either<Failure, List<PostModel>>> getNews() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/news.json');
      final List<dynamic> jsonData = json.decode(response);

      final List<PostModel> news = jsonData
          .map((e) => PostModel.fromJson(e))
          .where((news) => news.active) // Filtrar apenas as novidades ativas
          .toList();

      return Right(news);
    } catch (e) {
      return Left(FailureRequest(
        errorMessage: 'Erro ao carregar novidades',
        exception: e,
      ));
    }
  }
}
