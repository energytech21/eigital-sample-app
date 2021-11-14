
import 'package:dio/dio.dart';
import 'package:eigital_sample_app/models/news_api_result.dart';
import 'package:eigital_sample_app/services/news_service.dart';

class NewsRepository {

  final NewsService _newsService;

  NewsRepository({NewsService? newsService})
    : _newsService = newsService ?? NewsService();

  Future<NewsApiResult> getNews(int startPage, int pageSize) async {
    try{
      return await _newsService.getNews(startPage, pageSize);
    }
    on DioError catch(e){
      return NewsApiResult('error',code: '0', message: 'something happened on the Network');
    }
    catch (e) {
      return NewsApiResult('error',code: '0', message: 'something happened on the client side');
    }
  }
}