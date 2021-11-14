
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{

  HomeBloc() : super(HomeState(0,'Calculator')){
    on<NavigateTabEvent>(_onNavigateTab);
  }

  _onNavigateTab(NavigateTabEvent event, Emitter<HomeState> emit){
    switch(event.index){
      case 0:
        emit(HomeState(event.index, 'Calculator'));
        break;
      case 1:
        emit(HomeState(event.index, 'Location'));
        break;
      case 2:
        emit(HomeState(event.index, 'News'));
        break;
    }
  }
}

class HomeState {
  final int currentIndex;
  final String title;

  HomeState(this.currentIndex, this.title);
}
abstract class HomeEvent {}

class NavigateTabEvent extends HomeEvent {
  final int index;
  NavigateTabEvent(this.index);
}