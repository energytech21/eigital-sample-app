
import 'package:dio/dio.dart';
import 'package:eigital_sample_app/models/news_api_result.dart';

class NewsService {
  final String API_KEY = '91c852e15abe49aa8a0fab6d79b6a6b2';
  final String API_PATH = 'https://newsapi.org/v2/top-headlines';

  final _dio = Dio();

  Future<NewsApiResult> getNews(int startPage, int pageSize) async {
    var response = await _dio.get(API_PATH, queryParameters: {
      'apiKey': API_KEY,
      'page': startPage,
      'pageSize':pageSize,
      'language': 'en'
    });
    return NewsApiResult.fromJson(response.data);
  }
}