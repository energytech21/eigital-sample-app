
import 'package:eigital_sample_app/models/news.dart';
import 'package:eigital_sample_app/models/news_api_result.dart';
import 'package:eigital_sample_app/repositories/news_repository.dart';
import 'package:eigital_sample_app/screens/news/news_event.dart';
import 'package:eigital_sample_app/screens/news/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvent,NewsState>{
  final NewsRepository _newsRepository;

  int _currentPage = 1;
  int _pageSize = 20;

  int get currentPage => _currentPage;

  NewsBloc(this._newsRepository) : super(NewsFetchedState([],0)) {
    on<NewsFetchEvent>(_fetchNews);
  }

  Future<void> _fetchNews(NewsFetchEvent event, Emitter<NewsState> emitter) async {
    if(!(state is NewsFetchLoadingState)){
      emitter(NewsFetchLoadingState());
      var result = await _newsRepository.getNews(event.currentPage, _pageSize);
      _currentPage++;
      if(result.status == 'ok') {
        //add the recently fetched news on the last of the list. then re assign them in the result.articles
        event.currentList?.addAll(result.articles!);
        result.articles = event.currentList;
        emitter(NewsFetchedState(result.articles, result.articles?.length));
      }
      else {
        emitter(NewsFetchErrorState(result.message,result.code));
      }
    }
    
  }
}