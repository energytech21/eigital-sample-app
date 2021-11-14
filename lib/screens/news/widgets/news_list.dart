import 'package:eigital_sample_app/models/news.dart';
import 'package:eigital_sample_app/screens/news/news_bloc.dart';
import 'package:eigital_sample_app/screens/news/news_event.dart';
import 'package:eigital_sample_app/screens/news/news_state.dart';
import 'package:eigital_sample_app/screens/news/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsList extends StatelessWidget {
  final _scrollController = ScrollController();
  NewsList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc,NewsState>(
      bloc: context.read<NewsBloc>(),
      buildWhen: (prevState, newState) {
        return !(newState is NewsFetchLoadingState);
      },
      builder: (ctx, state) {
        if(state is NewsFetchedState){
          return NotificationListener(
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              controller: _scrollController,
              itemCount: state.articles?.length,
              itemBuilder: (ctx, index) {
                return NewsCard(news: state.articles![index]);
              }
            ),
            onNotification: (notif) {
              if(notif is ScrollEndNotification){
                if(notif.metrics.pixels > 0 && notif.metrics.atEdge){
                  fetchNews(context);
                }
              }
              return true;
            },
          );
        }
        else if(state is NewsFetchErrorState){
           return Center(child: Text("Error Occured ${state.message}"));
        } 

        return Container();
      },
    );
  }


  fetchNews(BuildContext context) {
    var bloc = context.read<NewsBloc>();
    if(bloc.state is NewsFetchedState){
      bloc.add(NewsFetchEvent(bloc.currentPage,(bloc.state as NewsFetchedState).articles));
    }
    else{
      bloc.add(NewsFetchEvent(bloc.currentPage,[]));
    }
  }
}