
import 'package:eigital_sample_app/models/source.dart';

class News {
  final Source source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  News(this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content);

  factory News.fromJson(Map<String,dynamic> json){
    return News(
      Source.fromJson(json['source']),
      json['author'], 
      json['title'],
      json['description'], 
      json['url'], 
      json['urlToImage'], 
      json['publishedAt'], 
      json['content']);
  }

  Map<String,dynamic> toJson() => {
    'source': this.source.toJson(),
    'author': this.author,
    'title': this.title,
    'description': this.description,
    'url': this.url,
    'urlToImage': this.urlToImage,
    'publishedAt': this.publishedAt,
    'content': this.content
  };
}