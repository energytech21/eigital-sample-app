

import 'package:eigital_sample_app/repositories/news_repository.dart';
import 'package:eigital_sample_app/services/news_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main (){
  test('api test', () async {
    var news = NewsRepository(newsService: NewsService());
    var result = await news.getNews(1, 20);
    expect(result.status,'ok');
  });
}