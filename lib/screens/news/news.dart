
import 'package:eigital_sample_app/screens/news/news_bloc.dart';
import 'package:eigital_sample_app/screens/news/news_event.dart';
import 'package:eigital_sample_app/screens/news/news_state.dart';
import 'package:eigital_sample_app/screens/news/widgets/news_list.dart';
import 'package:eigital_sample_app/shared/mixins/listenToStateChangeMixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
class NewsWidget extends StatefulWidget {
  
  const NewsWidget({ Key? key }) : super(key: key);

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> with ListenToStateChangeMixin<NewsState> {

  @override
  void initState() {
    super.initState();
    var bloc = context.read<NewsBloc>();
    bloc.add(NewsFetchEvent(bloc.currentPage, []));
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsBloc,NewsState>(
      listener: listenStateChange,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: NewsList(),
      ),
    );
  }

  @override
  void listenStateChange(BuildContext ctx, NewsState state) {
    if(state is NewsFetchLoadingState){
      showDialog(context: ctx, builder: (ctx) => AlertDialog(
        title: Text('Fetching news'),
        content: Text('Fetching news...'),
      ));
    }
    else{
      Navigator.of(ctx).popUntil((route) => route.settings.name == '/home');
    }
  }
}