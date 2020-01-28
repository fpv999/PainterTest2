import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:PainterTest2/core/models/app_tab.dart';

abstract class MainState extends Equatable {
  final AppTab tab;

  const MainState({@required this.tab});

  @override
  List<Object> get props => [tab];
}

class MainStateWorking extends MainState {
  MainStateWorking({@required AppTab tab}) : super(tab: tab);

  MainStateWorking copyWith({AppTab tab}) {
    return MainStateWorking(
      tab: tab ?? this.tab
    );
  }
}
