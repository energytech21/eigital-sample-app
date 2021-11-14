
import 'package:eigital_sample_app/models/news.dart';

abstract class NewsEvent {}

class NewsFetchEvent extends NewsEvent {
  final int currentPage;
  final List<News>? currentList;
  NewsFetchEvent(this.currentPage, this.currentList);
}

