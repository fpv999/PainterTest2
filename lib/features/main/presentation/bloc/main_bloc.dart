import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:PainterTest2/core/models/app_tab.dart';
import './bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  @override
  MainState get initialState => MainStateWorking(tab: AppTab.activity);

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is MainEventChangeTab) {
      yield MainStateWorking(tab: event.newTab);
      return;
    }
  }
}
