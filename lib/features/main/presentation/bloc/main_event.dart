import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:PainterTest2/core/models/app_tab.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class MainEventChangeTab extends MainEvent {
  final AppTab newTab;
  @override
  List<Object> get props => [newTab];

  MainEventChangeTab({@required this.newTab});
}