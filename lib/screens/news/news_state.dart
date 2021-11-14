
import 'package:eigital_sample_app/models/news.dart';
import 'package:eigital_sample_app/models/news_api_result.dart';
import 'package:equatable/equatable.dart';

abstract class NewsState extends Equatable {}

class NewsFetchedState extends NewsState {
  final List<News>? articles;
  final int? totalCount;
  NewsFetchedState(this.articles, this.totalCount);

  @override
  List<Object?> get props => [articles, totalCount];
}

class NewsFetchErrorState extends NewsState {
  final String? message;
  final String? code;

  NewsFetchErrorState(this.message, this.code);
  @override
  List<Object?> get props => [this.message,this.code];
}

class NewsFetchLoadingState extends NewsState {
  NewsFetchLoadingState();
  @override
  List<Object?> get props => [];
}
