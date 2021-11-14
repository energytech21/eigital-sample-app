import 'package:eigital_sample_app/models/news.dart';

class NewsApiResult {
  final String status;
  int? totalResults;
  List<News>? articles;
  String? code;
  String? message;

  NewsApiResult(this.status, {this.totalResults, this.articles, this.code, this.message}); 

  factory NewsApiResult.fromJson(Map<String,dynamic> json){
    var apiResult = NewsApiResult(json['status']);
    
    if(apiResult.status == 'ok'){
      apiResult.totalResults = json['totalResults'];
      apiResult.articles = (json['articles'] as List<dynamic>).map((e) => News.fromJson(e)).toList();
    }

    if(apiResult.status == 'error'){
      apiResult.code = json['code'];
      apiResult.message = json['message'];
    }

    return apiResult;
  }

}