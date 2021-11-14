import 'package:eigital_sample_app/repositories/news_repository.dart';
import 'package:eigital_sample_app/screens/calculator/calculator.dart';
import 'package:eigital_sample_app/screens/calculator/calculator_bloc.dart';
import 'package:eigital_sample_app/screens/home/home_bloc.dart';
import 'package:eigital_sample_app/screens/location/location.dart';
import 'package:eigital_sample_app/screens/location/location_bloc.dart';
import 'package:eigital_sample_app/screens/news/news.dart';
import 'package:eigital_sample_app/screens/news/news_bloc.dart';
import 'package:eigital_sample_app/shared/mixins/listenToStateChangeMixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, ListenToStateChangeMixin<HomeState> {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Text(state.title);
      })),
      body: BlocListener<HomeBloc, HomeState>(
        listener: listenStateChange,
        child: TabBarView(
          controller: _tabController,
          children: _renderChildren(),
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return BottomNavigationBar(
            currentIndex: state.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calculate), label: 'Calculator'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_pin), label: 'Location'),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.news),
                label: 'News',
              ),
            ],
            onTap: (index) =>
                context.read<HomeBloc>().add(NavigateTabEvent(index)));
      }),
    );
  }

  List<Widget> _renderChildren() {
    return [
      BlocProvider(
          create: (context) => CalculatorBloc(), child: CalculatorWidget()),
      BlocProvider(
          create: (context) => LocationBloc(), child: LocationWidget()),
      RepositoryProvider(
          create: (context) => NewsRepository(),
          child: BlocProvider(
              create: (context) => NewsBloc(context.read<NewsRepository>()),
              child: NewsWidget()))
    ];
  }

  @override
  void listenStateChange(BuildContext ctx, HomeState state) {
    _tabController.animateTo(state.currentIndex,
        duration: Duration(milliseconds: 300));
  }
}
